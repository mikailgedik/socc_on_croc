#!/bin/sh

set -eux

bender script verilator --target verilator > socc_on_croc.f
# TODO write code which generates less warnings..
# Max trace width needed to simulate SRAM arrays
verilator --binary -j 0 -CFLAGS -O0 -Wno-TIMESCALEMOD --trace-max-array 0 --trace-max-width 0 --trace-vcd --trace-structs --top tb_socc_on_croc -f socc_on_croc.f
echo "SIMULATING"
./obj_dir/Vtb_socc_on_croc
#gtkwave socc_on_croc.vcd
