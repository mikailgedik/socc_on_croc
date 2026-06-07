#!/bin/bash

set -eux

sftp -b - tmp-compter <<EOF
cd Desktop/rom_compress_rs
get target/release/stats.csv
get src/generated/test_gen_rom.sv ../../src/generated/test_gen_rom.sv
get verilator/output-rs.bin ../../verilator/output-rs.bin
EOF
