#!/bin/bash

set -eux

cargo build --release

sftp -b - tmp-compter <<EOF
cd Desktop/rom_compress_rs
put target/release/rom_compress_rs target/release/rom_compress_rs
put kernel.wgsl target/release/kernel.wgsl
put ../../verilator/stimuli/test1.data verilator/stimuli/test1.data
put ../../verilator/stimuli/font8bit.data verilator/stimuli/font8bit.data
EOF

ssh tmp-compter "cd ~/Desktop/rom_compress_rs/target/release &&
    chmod +x rom_compress_rs"
    # && time -p RUST_BACKTRACE=1 RUST_LOG=info ./rom_compress_rs"