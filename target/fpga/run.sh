#!/bin/bash -ex

#rm -rf build

DOCKER_ARGS="run --pull never -it --rm -m 16G -v $(pwd)/../..:/mnt -u $(id -u)"

# Specifically exclude xilinx tech cells (they don't work with yosys)
bender script -t fpga -t xilinx -t tech_cells_generic_include_tc_sram -t tech_cells_generic_exclude_xilinx_xpm -t tech_cells_generic_exclude_deprecated flist-plus | sed "s|$(cd ../.. && pwd)|..\/..|g" > flist.txt

DOCKER_TAIL_COMMAND="hpretl/iic-osic-tools:latest -s make -C /mnt/target/fpga -f Makefile /mnt/target/fpga/build/top.json"
docker $DOCKER_ARGS $DOCKER_TAIL_COMMAND

DOCKER_TAIL_COMMAND="regymm/openxc7:latest make -C /mnt/target/fpga -f Makefile"
docker $DOCKER_ARGS $DOCKER_TAIL_COMMAND

openFPGALoader --board zybo_z7_20 build/top.bit
