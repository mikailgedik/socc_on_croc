#!/bin/sh

set -eux

if [ "$1" = "socc" ]; then
    bender script verilator > socc_on_croc.f
    verilator --binary -j 0 -CFLAGS -O0 -Wno-TIMESCALEMOD  -Wno-fatal -Wno-WIDTHEXPAND -Wno-UNSIGNED --trace --trace-structs --top tb_socc_on_croc -f socc_on_croc.f
    echo "SIMULATING"
    ./obj_dir/Vtb_socc_on_croc
fi

if [ "$1" = "rom" ]; then
    cat > socc_on_croc.f <<EOF
    /home/mikail/Projects/stud/socc_on_croc/tb/tb_rom_compress.sv
    /home/mikail/Projects/stud/socc_on_croc/src/generated/test_gen_rom.sv
EOF
    # TODO write code which generates less warnings...
    verilator --binary -j 0 -CFLAGS -O0  --trace --trace-structs --top tb_rom_compress -f socc_on_croc.f
    echo "SIMULATING"
    ./obj_dir/Vtb_rom_compress
fi

#gtkwave socc_on_croc.vcd
