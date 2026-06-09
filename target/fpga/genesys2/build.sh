#!/bin/sh

set -e
mkdir -p ./out

yosys -p "plugin -i slang.so ; read_slang -f genesys2.flist -top genesys2_top ; synth_xilinx -abc9 -flatten; write_json ./out/top.json"
echo ">>> Yosys success"

nix develop github:openxc7/toolchain-nix -c bash << 'EOF'

set -e

nextpnr-xilinx \
    --chipdb out/xc7k325tffg900-2.bin \
    --xdc genesys2.xdc \
    --json out/top.json \
    --fasm out/top.fasm

echo ">>> nextpnr-xilinx success"

fasm2frames \
    --part xc7k325tffg900-2 \
    --db-root /nix/store/66lnijbk525xk113xkpqhcy3l3pnfk6f-nextpnr-xilinx-0.8.2/share/nextpnr/external/prjxray-db/kintex7 \
    out/top.fasm > out/top.frames

echo ">>> fasm2frames success"

xc7frames2bit \
    --part_file /nix/store/66lnijbk525xk113xkpqhcy3l3pnfk6f-nextpnr-xilinx-0.8.2/share/nextpnr/external/prjxray-db/kintex7/xc7k325tffg900-2/part.yaml \
    --part_name xc7k325tffg900-2 \
    --frm_file out/top.frames \
    --output_file out/top.bit

echo ">>> xc7frames2bit success"

openFPGALoader --board genesys2 out/top.bit

echo ">>> openFPGALoader success"

EOF

