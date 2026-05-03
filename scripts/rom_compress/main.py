#!/usr/bin/env python3

from logic_gen import Machine, Gates, FF_PER_STAGE, STAGE_COUNT
from io_ops import load_stimuli, write_to_file
from random import Random
import time

def main() -> None:
    stim : list[list[bool]] = load_stimuli("../../verilator/stimuli/ram_init.bin", FF_PER_STAGE)
    m = Machine().modified_clone(1, Random(0))
    # for i in range(8):
    #     m.stages_q[0].gates[i] = (Gates.AND, (i,i))  
    # m.stages_q[0].gates[0] = (Gates.NAND, (2,3))
    # m.stages_q[0].gates[1] = (Gates.NOR, (2,3))
    # m.stages_q[0].gates[2] = (Gates.XNOR, (2,3))
    # m.stages_q[0].gates[3] = (Gates.AND, (2,3))
    # m.stages_q[0].gates[4] = (Gates.OR, (2,3))
    # m.stages_q[0].gates[5] = (Gates.XOR, (2,3))
    # m.stages_q[0].gates[6] = (Gates.ZERO, (2,3))
    # m.stages_q[0].gates[7] = (Gates.ONE, (2,3))
    
    with open("../../src/generated/test_gen_rom.sv", "w") as f:
        f.write(m.to_system_verilog("test_gen_rom"))
    start = time.time_ns();
    res : list[list[bool]] = m.run(stim)
    print("Took: {:02f}ms".format((time.time_ns() - start) // 1_000_000))
    write_to_file("../../verilator/output2.bin", res)

def gen_stimuli():
    with open("../../verilator/stimuli/ram_init.bin", "wb") as f:
        ints_per_stage = ((FF_PER_STAGE + 31) // 32)
        for i in range(ints_per_stage * (STAGE_COUNT + 2000)):
            f.write(i.to_bytes(length=4, byteorder='little'))
            # f.write(bytes([(4*i) % 256,
            #                (4*i+1) % 256,
            #                (4*i+2) % 256,
            #                (4*i+3) % 256]))
            for _ in range(ints_per_stage - 1):
                f.write(bytes([0,0,0,0]))

if __name__ == '__main__':
    # gen_stimuli()
    main()