const total_machines: u32 = %TOTAL_MACHINES%;
const total_stages: u32 = %TOTAL_STAGES%;
const u32_max_per_stage: u32 = %U32_MAX_PER_STAGE%;
const u32_per_stage = array<u32, %TOTAL_STAGES%>(%U32_PER_STAGE%);
const prev_stage_width_ff = array<u32, %TOTAL_STAGES% + 1>(%PREV_STAGE_WIDTH_FF%);
const stimuli_length : u32 = %STIMULI_LENGTH%;
const stimuli_per_dispatch : u32 = %STIMULI_PER_DISPATCH%;

const MAX_MISTAKES = prev_stage_width_ff[total_stages] * stimuli_length;

override workers_x : u32 = 1;
override workers_y : u32 = 1;
override workers_z : u32 = 1;

alias arr_max_u32 = array<u32, u32_max_per_stage>;
alias arr_max_u32_stages = array<arr_max_u32, total_stages>;

@group(0) @binding(0) var<storage, read_write> sources_old: array<array<array<u32, u32_max_per_stage * 32>, total_stages>, total_machines>;
@group(0) @binding(1) var<storage, read_write> bitfiddle_old: array<array<array<vec4<u32>, u32_max_per_stage>, total_stages>, total_machines>;
@group(0) @binding(2) var<storage, read_write> sources_new: array<array<array<u32, u32_max_per_stage * 32>, total_stages>, total_machines>;
@group(0) @binding(3) var<storage, read_write> bitfiddle_new: array<array<array<vec4<u32>, u32_max_per_stage>, total_stages>, total_machines>;
@group(0) @binding(4) var<storage, read_write> machine_state_q: array<arr_max_u32_stages, total_machines>;
@group(0) @binding(5) var<storage, read_write> machine_state_d: array<arr_max_u32_stages, total_machines>;
@group(0) @binding(6) var<storage, read> stimuli: array<array<u32, (prev_stage_width_ff[0] + 31) / 32>, stimuli_length>;
@group(0) @binding(7) var<storage, read> golden: array<array<u32, u32_per_stage[total_stages - 1]>, stimuli_length>;
@group(0) @binding(8) var<storage, read_write> output: array<array<array<u32, u32_per_stage[total_stages - 1]>, stimuli_length>, total_machines>;
@group(0) @binding(9) var<storage, read_write> output_vs_golden: array<vec4<u32>, total_machines>;

struct Immediates {
    mode: u32,
    start_stimuli: u32,
    seed1: u32,
    temperature_bits: u32
};
var<immediate> immediates: Immediates;


//Copied from https://en.wikipedia.org/wiki/Xorshift#xorwow
struct XorWowState {
    x: array<u32, 5>,
    counter: u32,
};

fn random_xorwow(state: ptr<function, XorWowState>) -> u32 {
    // Algorithm "xorwow" from p. 5 of Marsaglia, "Xorshift RNGs"
    var t : u32 = (*state).x[4];
 
    var s : u32 = (*state).x[0]; // Perform a contrived 32-bit rotate.
    (*state).x[4] = (*state).x[3];
    (*state).x[3] = (*state).x[2];
    (*state).x[2] = (*state).x[1];
    (*state).x[1] = s;
 
    t ^= t >> 2;
    t ^= t << 1;
    t ^= s ^ (s << 4);
    (*state).x[0] = t;
    (*state).counter += 362437;
    return t + (*state).counter;
}

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
            let src_comb = sources_new[machine][stage][32 * k + j];
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
        machine_state_d[machine][stage][k] = (((srcBitsA & srcBitsB) & bitfiddle_new[machine][stage][k][0]) | ((srcBitsA ^ srcBitsB) & bitfiddle_new[machine][stage][k][1])) ^ bitfiddle_new[machine][stage][k][2];
    }
}

fn run_new_machine(machine: u32) {
    if(immediates.start_stimuli == 0) {
        output_vs_golden[machine][1] = 0;

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
            if (stimuli_idx >= total_stages + 1) {
                for(var u : u32 = 0; u < u32_per_stage[total_stages - 1]; u++) {
                    output_vs_golden[machine][1] += countOneBits(output[machine][stimuli_idx][u] ^ golden[stimuli_idx][u]);
                }
            }
        }
    }
}

fn replace_old_machine_if_new_is_better(machine: u32, rng: ptr<function, XorWowState>) {
    // After running, compare with the old machine
    var new_machine_better = output_vs_golden[machine][1] < output_vs_golden[machine][0];
    var overridden = false;
    if (!new_machine_better && output_vs_golden[machine][0] != 0) {
        let temp : f32 = bitcast<f32>(immediates.temperature_bits);
        if (temp > 0.000001) {
            let delta = f32(output_vs_golden[machine][0]) - f32(output_vs_golden[machine][1]);
            let exponent = delta / temp;
            if (exponent > -100) {
                var probability = exp2(exponent);
                if ((random_xorwow(rng) & 0xFFFF) < u32(probability * 0xFFFF)) {
                    overridden = true;
                    output_vs_golden[machine][3]++;
                }
            }
        }
        
    }
    if (new_machine_better || overridden) {
        // New machine is better than old machine, so copy
        output_vs_golden[machine][0] = output_vs_golden[machine][1];
        bitfiddle_old[machine] = bitfiddle_new[machine];
        sources_old[machine] = sources_new[machine];
        output_vs_golden[machine][2]++;
    }
}

fn create_new_machine(machine: u32, rng: ptr<function, XorWowState>) {
    if(output_vs_golden[machine][0] == 0) {
        return; // Working machine found - stop
    }
    for(var stage : u32 = 0; stage < total_stages; stage++) {
        for(var u : u32 = 0; u < u32_per_stage[stage]; u++) {
            var fiddlers : vec4<u32> = bitfiddle_old[machine][stage][u];
            for(var b : u32 = 0; b < 32; b++) {
                var src : u32 = sources_old[machine][stage][32 * u + b];
                var rand_val : u32 = random_xorwow(rng);
                if((rand_val & 0xFFFF) < immediates.start_stimuli) {
                    fiddlers[0] ^= ((rand_val >> 16) & 1) << b;
                    fiddlers[1] ^= ((rand_val >> 17) & 1) << b;
                    fiddlers[2] ^= ((rand_val >> 18) & 1) << b;
                    
                    rand_val = random_xorwow(rng);
                    src = (rand_val % prev_stage_width_ff[stage]) & 0xFFFF;
                    src |= (((rand_val >> 16) % prev_stage_width_ff[stage]) & 0xFFFF) << 16;
                }
                sources_new[machine][stage][32 * u + b] = src;
            }
            bitfiddle_new[machine][stage][u] = fiddlers;
        }
        let res : u32 = prev_stage_width_ff[stage + 1] % 32;
        if (res != 0) {
            let mask : u32 = u32((1 << res) - 1);
            bitfiddle_new[machine][stage][u32_per_stage[stage] - 1][0] &= mask;
            bitfiddle_new[machine][stage][u32_per_stage[stage] - 1][1] &= mask;
            bitfiddle_new[machine][stage][u32_per_stage[stage] - 1][2] &= mask;
        }
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
    let workgroup_linear = workgroup_id.z * num_workgroups.y * num_workgroups.x +
                        workgroup_id.y * num_workgroups.x +
                        workgroup_id.x;
    let machine : u32 = 
        workgroup_linear * (workers_x * workers_y * workers_z) +
        local_invocation_index;
    let total = total_machines;

    // workgroup_size may not be a multiple of the array size so
    // we need to exit out a thread that would index out of bounds.
    if (machine >= total) {
        return;
    }

    if(immediates.mode == 0) {
        //NOP i guess? TODO?
        // Placeholder for now
    } else if(immediates.mode == 1) {
        run_new_machine(machine);
    } else if(immediates.mode == 2) {
        var rng: XorWowState = XorWowState(array<u32, 5>(immediates.seed1 ^ machine, 0xdeadbeef, 0x78a8fda8, immediates.seed1 + machine, immediates.seed1 & machine),
            (immediates.seed1 << 3) + machine
        );
        for(var i = 0; i < 32; i++) {
            random_xorwow(&rng);
        }
        
        replace_old_machine_if_new_is_better(machine, &rng);

        create_new_machine(machine, &rng);     
    } else if(immediates.mode == 1024) {
        var rng: XorWowState = XorWowState(array<u32, 5>(immediates.seed1 ^ machine, 0xdeadbeef, 0x78a8fda8, immediates.seed1 + machine, immediates.seed1 & machine),
            (immediates.seed1 << 3) + machine
        );
        for(var i = 0; i < 32; i++) {
            random_xorwow(&rng);
        }
        for(var i : u32 = 0; i < stimuli_length; i++) {
            output[machine][i][0] = random_xorwow(&rng);
        }
    }
}
