#!/usr/bin/env python3

from logic_gen import Machine
from io_ops import load_stimuli, write_to_file
from random import Random
import time
from multiprocessing import Pool

def cmp_rsp_gold(rsp: list[bytes], gold: list[bytes]) -> int:
    assert len(rsp) == len(gold), f"{len(rsp)}, {len(gold)}"
    mistake_sum = 0
    for i in range(len(rsp)):
        for j in range(len(rsp[i])):
            diff = rsp[i][j] ^ gold[i][j]
            for k in range(8):
                mistake_sum += (diff >> k) & 1
            # rdiff = (diff >> 5) & 0b111
            # gdiff = (diff >> 2) & 0b111
            # bdiff = (diff << 1) & 0b111
            
            # mistake_sum += rdiff + gdiff + bdiff
            # mistake_sum += ((((diff >> 7) & 1) + ((diff >> 4) & 1) + ((diff >> 1) & 1)) * 8 +
            #                 (((diff >> 6) & 1) + ((diff >> 3) & 1) + ((diff >> 0) & 1)) * 4 +
            #                 (((diff >> 5) & 1) + ((diff >> 2) & 1)))
    return mistake_sum

def tmp(param : tuple[Machine, list[bytes], int, list[bytes]]) -> int:
    return cmp_rsp_gold(param[0].run(param[1])[param[2]:], param[3])

THREADS = 1

def optimize_machine(m: Machine, iterations: int, stages: list[int],
                     raw_stim: list[bytes], raw_gold: list[bytes], gold_range: tuple[int, int],
                     randomness: float, start_temp: float, rng: Random) -> Machine:
    

    # Latency of the FSM
    extra_cycles = len(m.stage_comb) - 1

    golden = raw_gold[gold_range[0]:gold_range[1]]
    best_machine = m
    stim = raw_stim[gold_range[0]:gold_range[1]]
    stim.extend([bytes(((Machine.INPUT_WIDTH + 31) // 32) * 4) for _ in range(extra_cycles)])
    start : int = time.time_ns()
    res = m.run(stim)
    best = cmp_rsp_gold(res[extra_cycles:], golden)
    temperature = start_temp
    print("Took: {:02f}ms. Initial: {score}".format((time.time_ns() - start) // 1_000_000, score=best))

    for i in range(iterations):
        randomness *= (1 - 1 / iterations)
        temperature *= (1 - 1 / iterations)
        print(f"T: {temperature:02f}, rng: {randomness:02f}")
        start = time.time_ns()
        
        new_m = m.modified_clone(randomness, stages, rng)
        res = new_m.run(stim)
        score = cmp_rsp_gold(res[extra_cycles:], golden)

        acceptance_force_rate = 0.0
        if temperature != 0 and (score - best) / temperature < 100 and score >= best:
            acceptance_force_rate = 2**(- (score - best) / temperature)
        if best == 0:
            print("Best found!")
            return m
        elif score < best:
            print("Took {i}: {t:02f}ms. Score {score}, {better}".format(i=i, t=(time.time_ns() - start) // 1_000_000, score=score, better=("BETTER" if score < best else "NOGOOD")))
            m = new_m
            best = score
            best_machine = new_m
        elif rng.random() < acceptance_force_rate:
            m = new_m
            print(f"Overridden with: {acceptance_force_rate:02f}")
            print("Took {i}: {t:02f}ms. Score {score}, {better}".format(i=i, t=(time.time_ns() - start) // 1_000_000, score=score, better="OVERRIDDEN!"))
        else:
            print("Took {i}: {t:02f}ms. Score {score}, {better}".format(i=i, t=(time.time_ns() - start) // 1_000_000, score=score, better=("BETTER" if score < best else "NOGOOD")))
    
    return best_machine

def main() -> None:
    # golden : list[bytes] = load_stimuli("../../verilator/stimuli/test1.data", Machine.FF_PER_STAGE[-1])
    golden : list[bytes] = [bytes(4 * ((Machine.FF_PER_STAGE[-1] + 31) // 32)) for _ in range(640//4)]
    # for i in range(8):
    #     golden[i] = bytes([255,255,255,255])
    stim : list[bytes] = load_stimuli("../../verilator/stimuli/ram_init.bin", Machine.INPUT_WIDTH)

    
    min_len = min(len(golden), len(stim))
    golden = golden[:min_len]
    stim = stim[:min_len]
    print("Length: ", min_len)

    rng = Random(0)
    m = Machine().modified_clone(1, None, rng)
    m = Machine()
    randomness = 0.01
    temperature : float = 10
    # for outer_var in range(len(m.FF_PER_STAGE)):
    for outer_var in range(1):
        m = optimize_machine(m, 1000, list(range(len(m.FF_PER_STAGE) - outer_var - 1, len(m.FF_PER_STAGE))),
                             stim, golden, (0,len(golden)), randomness, temperature, rng)
        
        print("Saving thingy")
        with open("../../src/generated/test_gen_rom.sv", "w") as f:
            f.write(m.to_system_verilog("test_gen_rom"))

    with open("../../src/generated/test_gen_rom.sv", "w") as f:
        f.write(m.to_system_verilog("test_gen_rom"))
    
    # write_to_file("../../verilator/output2.bin", res)

def gen_stimuli():
    with open("../../verilator/stimuli/ram_init.bin", "wb") as f:
        for i in range(((Machine.INPUT_WIDTH + 31) // 32) * (len(Machine.FF_PER_STAGE) + 1024 * 512)):
            f.write(i.to_bytes(4, 'little'))

if __name__ == '__main__':
    gen_stimuli()
    main()