#!/usr/bin/env python3

from logic_gen import Machine
from io_ops import load_stimuli, write_to_file
from random import Random
import time
from multiprocessing import Pool
from dataclasses import dataclass
from operator import itemgetter

def cmp_rsp_gold(rsp: list[bytes], gold: list[bytes]) -> int:
    assert len(rsp) == len(gold), f"{len(rsp)}, {len(gold)}"
    mistake_sum = 0
    for i in range(len(rsp)):
        for j in range(len(rsp[i])):
            diff = rsp[i][j] ^ gold[i][j]
            # for k in range(8):
            #     mistake_sum += (diff >> k) & 1
            # rdiff = (diff >> 5) & 0b111
            # gdiff = (diff >> 2) & 0b111
            # bdiff = (diff << 1) & 0b111
            
            # mistake_sum += rdiff + gdiff + bdiff
            mistake_sum += ((((diff >> 7) & 1) + ((diff >> 4) & 1) + ((diff >> 1) & 1)) * 8 +
                            (((diff >> 6) & 1) + ((diff >> 3) & 1) + ((diff >> 0) & 1)) * 4 +
                            (((diff >> 5) & 1) + ((diff >> 2) & 1)))
    return mistake_sum

@dataclass
class OneMachineRun:
    m: Machine
    stim: list[bytes]
    stim_offset: int
    golden: list[bytes]

def run_one_machine(param : OneMachineRun) -> tuple[Machine, int]:
    score : int = cmp_rsp_gold(param.m.run(param.stim)[param.stim_offset:], param.golden)

    return (param.m, score)

THREADS = 48
WORKS = THREADS * 4

def optimize_machine(start_machines: list[tuple[Machine, int]], iterations: int, stages: list[int],
                     raw_stim: list[bytes], raw_gold: list[bytes], gold_range: tuple[int, int],
                     randomness: float, start_temp: float, rng: Random) -> list[tuple[Machine, int]]:
    # Latency of the FSM
    extra_cycles : int = len(start_machines[0][0].stage_comb) - 1
    golden = raw_gold[gold_range[0]:gold_range[1]]
    temperature = start_temp

    stim = raw_stim[gold_range[0]:gold_range[1]]
    stim.extend([bytes(((Machine.INPUT_WIDTH + 31) // 32) * 4) for _ in range(extra_cycles)])

    # start : int = time.time_ns()
    # start_machine_score = cmp_rsp_gold(start_machine.run(stim)[extra_cycles:], golden)
    # print("Took: {:02f}ms. Initial: {score}".format((time.time_ns() - start) // 1_000_000, score=start_machine_score))
    # machines : list[tuple[Machine, int]] = list((start_machine, start_machine_score) for _ in range(WORKS))
    machines : list[tuple[Machine, int]] = start_machines
    with Pool(THREADS) as p:
        for i in range(iterations):
            randomness *= (1 - 1 / iterations)
            temperature *= (1 - 1 / iterations)
            print(f"T: {temperature:02f}, rng: {randomness:02f}")
            start = time.time_ns()
            
            start = time.time_ns()
            new_machines : list[tuple[Machine, int]] = p.map(run_one_machine,
                    tuple(OneMachineRun(m=machines[j][0].modified_clone(randomness, stages, rng), stim=stim,
                                        stim_offset=extra_cycles, golden=golden) for j in range(WORKS)))        
            print(f"Run {i}: {(time.time_ns() - start) // 1_000_000}. ms")
            for j in range(WORKS):                
                score_diff = new_machines[j][1] - machines[j][1]

                if score_diff < 0:
                    print(f"ACCEPT: {j}: {new_machines[j][1]}")
                    machines[j] = new_machines[j]
                    if machines[j][1] == 0:
                        print("Found optimal")
                        machines.sort(key=itemgetter(1))
                        return machines
                else:
                    acceptance_force_rate = 0.0
                    if temperature != 0 and score_diff / temperature < 100 and score_diff > 0:
                        acceptance_force_rate = 2**(- score_diff / temperature)
                    if rng.random() < acceptance_force_rate:
                        print(f"OVERRIDE: {j} {acceptance_force_rate:02f}: {new_machines[j][1]}")
                        machines[j] = new_machines[j]
                    else:
                        print(f"NOGOOD: {j} : {new_machines[j][1]}")
            
            if i % 100 == 0:
                machines.sort(key=itemgetter(1))
                for j in range(WORKS//2, WORKS):
                    if rng.random() < 0.1:
                        machines[j] = machines[rng.randint(0, WORKS//2 - 1)]
                        print(f"Machine {j} replaced!")
    machines.sort(key=itemgetter(1))
    return machines

def main() -> None:
    # golden : list[bytes] = load_stimuli("../../verilator/stimuli/test1.data", Machine.FF_PER_STAGE[-1])
    golden : list[bytes] = [bytes(4 * ((Machine.FF_PER_STAGE[-1] + 31) // 32)) for _ in range(640//4)]
    for i in range(len(golden)):
        golden[i] = bytes([255,255,255,255])
    stim : list[bytes] = load_stimuli("../../verilator/stimuli/ram_init.bin", Machine.INPUT_WIDTH)

    
    min_len = min(len(golden), len(stim))
    golden = golden[:min_len]
    stim = stim[:min_len]
    print("Length: ", min_len)

    rng = Random(0)
    machines : list[tuple[Machine, int]] = list((Machine(), 9999999999999999999999) for _ in range(WORKS))
    randomness = 0.03
    temperature : float = 100
    for outer_var in range(len(machines[0][0].stage_comb)):
        machines = optimize_machine(machines, 1000, list(range(len(machines[0][0].stage_comb) - outer_var - 1, len(machines[0][0].stage_comb))),
                             stim, golden, (0,len(golden)), randomness, temperature, rng)
        
        # best solution is always zero'th index
        print("Saving thingy")
        with open("../../src/generated/test_gen_rom.sv", "w") as f:
            f.write(machines[0][0].to_system_verilog("test_gen_rom"))

    # write_to_file("../../verilator/output2.bin", res)

def gen_stimuli():
    with open("../../verilator/stimuli/ram_init.bin", "wb") as f:
        for i in range(((Machine.INPUT_WIDTH + 31) // 32) * (len(Machine.FF_PER_STAGE) + 1024 * 512)):
            f.write(i.to_bytes(4, 'little'))

if __name__ == '__main__':
    gen_stimuli()
    main()