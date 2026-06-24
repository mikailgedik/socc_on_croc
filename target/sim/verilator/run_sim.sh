#!/bin/sh

set -eux

bender script verilator --target verilator > socc_on_croc.f
# TODO write code which generates less warnings..
# To simulate large arrays: Set "--trace-max-array 0 --trace-max-width 0"
verilator --binary -j 0 -O3 -Wno-TIMESCALEMOD --trace-max-array 0 --trace-max-width 4096 --trace-fst --trace-structs --top tb_socc_on_croc -f socc_on_croc.f
echo "SIMULATING"
./obj_dir/Vtb_socc_on_croc
#gtkwave socc_on_croc.vcd
