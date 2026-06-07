const TOTAL_MACHINES: u32 = %TOTAL_MACHINES%;
const TOTAL_FF: u32 = %TOTAL_FF%;
const U32_NEEDED_FOR_FF: u32 = %U32_NEEDED_FOR_FF%;
const PREVIOUS_STAGE_FF_ARRAY_LENGTH = %PREVIOUS_STAGE_FF_ARRAY_LENGTH%;
const PREVIOUS_STAGE_FF = array<u32, PREVIOUS_STAGE_FF_ARRAY_LENGTH>(%PREVIOUS_STAGE_FF%);
const OUTPUT_START : u32 = %OUTPUT_START%;
const STIMULI_LENGTH : u32 = %STIMULI_LENGTH%;
const STIMULI_PER_DISPATCH : u32 = %STIMULI_PER_DISPATCH%;

override workers_x : u32 = 1;
override workers_y : u32 = 1;
override workers_z : u32 = 1;

@group(0) @binding(0) var<storage, read_write> sources_old: array<array<u32, U32_NEEDED_FOR_FF * 32>, TOTAL_MACHINES>;
@group(0) @binding(1) var<storage, read_write> bitfiddle_old: array<array<vec4<u32>, U32_NEEDED_FOR_FF>, TOTAL_MACHINES>;
@group(0) @binding(2) var<storage, read_write> sources_new: array<array<u32, U32_NEEDED_FOR_FF * 32>, TOTAL_MACHINES>;
@group(0) @binding(3) var<storage, read_write> bitfiddle_new: array<array<vec4<u32>, U32_NEEDED_FOR_FF>, TOTAL_MACHINES>;
@group(0) @binding(4) var<storage, read_write> machine_state_q: array<array<u32, U32_NEEDED_FOR_FF>, TOTAL_MACHINES>;
@group(0) @binding(5) var<storage, read_write> machine_state_d: array<array<u32, U32_NEEDED_FOR_FF>, TOTAL_MACHINES>;
@group(0) @binding(6) var<storage, read> stimuli: array<array<u32, (PREVIOUS_STAGE_FF[0] + 31) / 32>, STIMULI_LENGTH>;
@group(0) @binding(7) var<storage, read> golden: array<array<u32, (PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF_ARRAY_LENGTH - 1] + 31) / 32>, STIMULI_LENGTH>;
@group(0) @binding(8) var<storage, read_write> output: array<array<array<u32, (PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF_ARRAY_LENGTH - 1] + 31) / 32>, STIMULI_LENGTH>, TOTAL_MACHINES>;
@group(0) @binding(9) var<storage, read_write> output_vs_golden: array<vec4<u32>, TOTAL_MACHINES>;

struct Immediates {
    mode: u32,
    arg1: u32,
    arg2: u32,
    arg3: u32
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

fn calculate_next_state(
    machine: u32,
    stimuli_idx: u32,
    ) {
    var idxA : u32;
    var idxB : u32;
    var srcBitsA : u32;
    var srcBitsB : u32;
    for(var u : u32 = 0; u < U32_NEEDED_FOR_FF; u++) {
        srcBitsA = 0;
        srcBitsB = 0;
        for(var b : u32 = 0; b < 32; b++) {
            let j : u32 = 31 - b;
            let src_comb = sources_new[machine][32 * u + j];
            idxA =  src_comb & 0xFFFF;
            idxB = (src_comb >> 16) & 0xFFFF;
            srcBitsA <<= 1;
            srcBitsB <<= 1;
            
            if (32 * u + j < PREVIOUS_STAGE_FF[1]) {// Still in stage 0
                srcBitsA |= (stimuli[stimuli_idx][idxA / 32] >> (idxA % 32)) & 1;
                srcBitsB |= (stimuli[stimuli_idx][idxB / 32] >> (idxB % 32)) & 1;
            } else {
                srcBitsA |= (machine_state_q[machine][idxA / 32] >> (idxA % 32)) & 1;
                srcBitsB |= (machine_state_q[machine][idxB / 32] >> (idxB % 32)) & 1;
            }
        }
        machine_state_d[machine][u] = (((srcBitsA & srcBitsB) & bitfiddle_new[machine][u][0]) | ((srcBitsA ^ srcBitsB) & bitfiddle_new[machine][u][1])) ^ bitfiddle_new[machine][u][2];
    }
}

fn run_new_machine(machine: u32, start_stimuli: u32) {
    if(start_stimuli == 0) {
        output_vs_golden[machine][1] = 0;
        
        for(var i : u32 = 0; i < U32_NEEDED_FOR_FF; i++) {
            machine_state_d[machine][i] = 0;
            machine_state_q[machine][i] = 0;
        }
    }

    for(var i : u32 = 0; i < STIMULI_PER_DISPATCH; i++) {
        let stimuli_idx = start_stimuli + i;
        if (stimuli_idx < STIMULI_LENGTH) {
            calculate_next_state(machine,stimuli_idx);
            
            machine_state_q[machine] = machine_state_d[machine];
            const output_start_u32 = OUTPUT_START / 32;
            const residual = OUTPUT_START % 32;
            if (residual == 0) {
                for(var u : u32 = 0; u < (PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF_ARRAY_LENGTH - 1] + 31) / 32; u++) {
                    output[machine][stimuli_idx][u] = machine_state_q[machine][output_start_u32 + u];
                }
            } else {
                const shift_right = residual;
                const shift_left = (32 - shift_right) % 32; // Compiler is unhappy if we don't add %32
                // Output start = 3
                //[][][][][...X_XXXX][XXXX_XXXX][XX.._....]
                //[][][]
                for(var u : u32 = 0; u < (PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF_ARRAY_LENGTH - 1] + 31) / 32; u++) {
                    output[machine][stimuli_idx][u] =
                        machine_state_q[machine][output_start_u32 + u] >> shift_right;
                    if (output_start_u32 + u + 1 < U32_NEEDED_FOR_FF) {
                        output[machine][stimuli_idx][u] |= machine_state_q[machine][output_start_u32 + u + 1] << shift_left;   
                    }
                }
            }

            // (32, 32) = 2 ---> 0

            if (stimuli_idx >= PREVIOUS_STAGE_FF_ARRAY_LENGTH - 2) {
                for(var u : u32 = 0; u < (PREVIOUS_STAGE_FF[PREVIOUS_STAGE_FF_ARRAY_LENGTH - 1] + 31) / 32; u++) {
                    output_vs_golden[machine][1] += countOneBits(output[machine][stimuli_idx][u] ^ golden[stimuli_idx][u]);
                }
            }
        }
    }
}

fn replace_old_machine_if_new_is_better(machine: u32, temp: f32 ,rng: ptr<function, XorWowState>) {
    // After running, compare with the old machine
    let new_machine_better : bool = output_vs_golden[machine][1] < output_vs_golden[machine][0];
    var overridden = false;
    if (!new_machine_better && output_vs_golden[machine][0] != output_vs_golden[machine][1] && output_vs_golden[machine][0] != 0 && temp > 0.000001) {
        let delta : f32 = f32(output_vs_golden[machine][0]) - f32(output_vs_golden[machine][1]);
        let exponent : f32 = delta / temp;
        if (exponent > -100.0) {
            let probability : f32 = exp2(exponent);
            if ((random_xorwow(rng) & 0xFFFF) < u32(probability * 0xFFFF)) {
                overridden = true;
                output_vs_golden[machine][3]++;
                output_vs_golden[machine][2]--;
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

fn create_new_machine(machine: u32, mutation_chance: u32, rng: ptr<function, XorWowState>) {
    if(output_vs_golden[machine][0] == 0) {
        return; // Working machine found - stop
    }

    // Weird starting values to account for the input stage
    // which has the indices is not in machine_state_d but in the stimuli
    var previous_stage_start : u32 = 0;
    var previous_stage_end : u32 = 0;
    var stage : u32 = 0;

    for(var u : u32 = 0; u < U32_NEEDED_FOR_FF; u++) {
        var fiddlers : vec4<u32> = bitfiddle_old[machine][u];
        for(var b : u32 = 0; b < 32; b++) {
            let current_bit = 32 * u + b;
            if (current_bit >= TOTAL_FF) {
                continue;
            }
            // Current bit is actually in next stage
            //
            // A A A B B C C C
            // |     |
            //           ^
            if (current_bit - previous_stage_end == PREVIOUS_STAGE_FF[stage + 1]) {
                if(stage == 0) {
                    previous_stage_start = 0;
                } else {
                    previous_stage_start = previous_stage_end;
                }
                previous_stage_end = current_bit;
                stage++;
            }

            var src : u32 = sources_old[machine][current_bit];
            var rand_val : u32 = random_xorwow(rng);
            if((rand_val & 0xFFFF) < mutation_chance) {
                fiddlers[0] ^= ((rand_val >> 16) & 1) << b;
                fiddlers[1] ^= ((rand_val >> 17) & 1) << b;
                fiddlers[2] ^= ((rand_val >> 18) & 1) << b;
                
                rand_val = random_xorwow(rng);
                src = (rand_val % PREVIOUS_STAGE_FF[stage] + previous_stage_start) & 0xFFFF;
                src |= (((rand_val >> 16) % PREVIOUS_STAGE_FF[stage] + previous_stage_start) & 0xFFFF) << 16;
            }
            sources_new[machine][32 * u + b] = src;
        }
        bitfiddle_new[machine][u] = fiddlers;
    }
    let upper_ones : u32 = U32_NEEDED_FOR_FF * 32 - TOTAL_FF;
    if (upper_ones != 0) {
        let mask : u32 = bitcast<u32>(-1) >> upper_ones;
        bitfiddle_new[machine][U32_NEEDED_FOR_FF - 1][0] &= mask;
        bitfiddle_new[machine][U32_NEEDED_FOR_FF - 1][1] &= mask;
        bitfiddle_new[machine][U32_NEEDED_FOR_FF - 1][2] &= mask;
        bitfiddle_new[machine][U32_NEEDED_FOR_FF - 1][3] &= mask;
        
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

    // workgroup_size may not be a multiple of the array size so
    // we need to exit out a thread that would index out of bounds.
    if (machine >= TOTAL_MACHINES) {
        return;
    }

    if(immediates.mode == 0) {
        //NOP i guess? TODO?
        // Placeholder for now
    } else if(immediates.mode == 1) {
        let start_stimuli = immediates.arg1;
        run_new_machine(machine, start_stimuli);
    } else if(immediates.mode >= 2 && immediates.mode <= 4) {
        let seed = immediates.arg1;
        let temp: f32 = bitcast<f32>(immediates.arg2);
        let mutation_chance = immediates.arg3;
        var rng: XorWowState = XorWowState(array<u32, 5>(seed ^ machine, 0xdeadbeef, 0x78a8fda8, seed + machine, seed & machine),
            (seed << 3) + machine
        );
        for(var i = 0; i < 32; i++) {
            random_xorwow(&rng);
        }
        
        if(immediates.mode == 2 || immediates.mode == 4) {
            replace_old_machine_if_new_is_better(machine, temp, &rng);
        }
        if(immediates.mode == 3 || immediates.mode == 4) {
            create_new_machine(machine, mutation_chance, &rng);
        }
    }
}
