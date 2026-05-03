#!/usr/bin/env python3

from logic_gen import Machine
from io_ops import load_stimuli, write_to_file
from random import Random
import time

def main() -> None:
    stim : list[bytes] = load_stimuli("../../verilator/stimuli/ram_init.bin", Machine.INPUT_WIDTH)
    m = Machine().modified_clone(1, Random(0))
    
    with open("../../src/generated/test_gen_rom.sv", "w") as f:
        f.write(m.to_system_verilog("test_gen_rom"))
    start = time.time_ns()
    res : list[bytes] = m.run(stim)
    print("Took: {:02f}ms".format((time.time_ns() - start) // 1_000_000))
    write_to_file("../../verilator/output2.bin", res)

def gen_stimuli():
    with open("../../verilator/stimuli/ram_init.bin", "wb") as f:
        for i in range(((Machine.INPUT_WIDTH + 31) // 32) * (len(Machine.FF_PER_STAGE) + 20)):
            f.write(i.to_bytes(length=4, byteorder='little'))
            f.write(i.to_bytes(4, 'little'))

if __name__ == '__main__':
    gen_stimuli()
    main()