const total_stages: u32 = %TOTAL_STAGES%;
const u32_max_per_stage: u32 = %U32_MAX_PER_STAGE%;
const u32_per_stage = array<u32, %TOTAL_STAGES%>(%U32_PER_STAGE%);
const stimuli_length : u32 = %STIMULI_LENGTH%;
const stimuli_per_dispatch : u32 = %STIMULI_PER_DISPATCH%;

override workers_x : u32 = 1;
override workers_y : u32 = 1;
override workers_z : u32 = 1;

alias arr_max_u32 = array<u32, u32_max_per_stage>;
alias arr_max_u32_stages = array<arr_max_u32, total_stages>;

@group(0) @binding(0) var<storage, read> in_sources: array<array<array<u32, u32_max_per_stage * 32>, total_stages>>;
@group(0) @binding(1) var<storage, read> in_and_enables: array<arr_max_u32_stages>;
@group(0) @binding(2) var<storage, read> in_xor_enables: array<arr_max_u32_stages>;
@group(0) @binding(3) var<storage, read> in_inv_enables: array<arr_max_u32_stages>;
@group(0) @binding(4) var<storage, read_write> machine_state_q: array<arr_max_u32_stages>;
@group(0) @binding(5) var<storage, read_write> machine_state_d: array<arr_max_u32_stages>;
@group(0) @binding(6) var<storage, read> stimuli: array<arr_max_u32, stimuli_length>;
// @group(0) @binding(7) var<storage, read> golden: array<arr_max_u32, stimuli_length>;
@group(0) @binding(7) var<storage, read_write> output: array<array<array<u32, u32_per_stage[total_stages - 1]>, stimuli_length>>;

struct Immediates {
    start_stimuli: u32,
    mode: u32,
    // salt: u32
};
var<immediate> immediates: Immediates;

fn calculate_stage(machine: u32, stage: u32, stimuli_idx: u32) {
    var idxA : u32;
    var idxB : u32;
    var srcBitsA : u32;
    var srcBitsB : u32;
    for(var k : u32 = 0; k < u32_per_stage[stage]; k++) {
        srcBitsA = 0;
        srcBitsB = 0;
        for(var b : u32 = 0; b < 32; b++) {
            let j : u32 = 31 - b;
            let src_comb = in_sources[machine][stage][32 * k + j];
            idxA =  src_comb & 0xFFFF;
            idxB = (src_comb >> 16) & 0xFFFF;
            srcBitsA <<= 1;
            srcBitsB <<= 1;
            
            if (stage == 0) {
                srcBitsA |= (stimuli[stimuli_idx][idxA / 32] >> (idxA % 32)) & 1;
                srcBitsB |= (stimuli[stimuli_idx][idxB / 32] >> (idxB % 32)) & 1;
            } else {
                srcBitsA |= (machine_state_q[machine][stage - 1][idxA / 32] >> (idxA % 32)) & 1;
                srcBitsB |= (machine_state_q[machine][stage - 1][idxB / 32] >> (idxB % 32)) & 1;
            }
        }
        machine_state_d[machine][stage][k] = (((srcBitsA & srcBitsB) & in_and_enables[machine][stage][k]) | ((srcBitsA ^ srcBitsB) & in_xor_enables[machine][stage][k])) ^ in_inv_enables[machine][stage][k];
    }
}

// Tells wgpu that this function is a valid compute pipeline entry_point
@compute
// Specifies the "dimension" of this work group
@workgroup_size(workers_x, workers_y, workers_z)
fn main(
    // global_invocation_id specifies our position in the invocation grid
    @builtin(workgroup_id) workgroup_id: vec3<u32>,
    @builtin(num_workgroups) num_workgroups: vec3<u32>,
    @builtin(local_invocation_index) local_invocation_index: u32,
) {
    _ = in_sources[0];
    _ = in_and_enables[0];
    _ = in_xor_enables[0];
    _ = in_inv_enables[0];
    _ = machine_state_q[0];
    _ = machine_state_d[0];
    _ = stimuli[0];
    _ = output[0];

    let workgroup_linear = workgroup_id.z * num_workgroups.y * num_workgroups.x +
                        workgroup_id.y * num_workgroups.x +
                        workgroup_id.x;
    let machine = 
        workgroup_linear * (workers_x * workers_y * workers_z) +
        local_invocation_index;
    let total = arrayLength(&in_sources);

    // workgroup_size may not be a multiple of the array size so
    // we need to exit out a thread that would index out of bounds.
    if (machine >= total) {
        return;
    }

    if(immediates.start_stimuli == 0) {
        for(var i : u32 = 0; i < total_stages; i++) {
            for(var j : u32 = 0; j < u32_max_per_stage; j++) {
                machine_state_q[machine][i][j] = 0;
                machine_state_d[machine][i][j] = 0;
            }
        }
    }

    for(var i : u32 = 0; i < stimuli_per_dispatch; i++) {
        let stimuli_idx = immediates.start_stimuli + i;
        if (stimuli_idx < stimuli_length) {
            for(var stage : u32 = 0; stage < total_stages; stage++) {
                calculate_stage(machine, stage, stimuli_idx);
            }
            machine_state_q[machine] = machine_state_d[machine];
            for(var u : u32 = 0; u < u32_per_stage[total_stages - 1]; u++) {
                output[machine][stimuli_idx][u] = machine_state_q[machine][total_stages - 1][u];
            }
        }
    }
}
