#!/bin/sh

set -eux

bender script verilator > socc_on_croc.f
# TODO write code which generates less warnings...
verilator --binary -j 0 -Wno-TIMESCALEMOD -CFLAGS -O0 -Wno-fatal -Wno-WIDTHEXPAND -Wno-UNSIGNED --trace --trace-structs --top tb_socc_on_croc -f socc_on_croc.f
echo "SIMULATING"
./obj_dir/Vtb_socc_on_croc
#gtkwave socc_on_croc.vcd
