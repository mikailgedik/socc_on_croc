#!/bin/bash -ex

rm -rf build

DOCKER_ARGS="run --pull never -it --rm -m 8G -v $(pwd)/..:/mnt -v /chipdb:/chipdb -v $(pwd)/tmp:/tmp -u $(id -u)"

bender script -t fpga -t xilinx -t tech_cells_generic_exclude_deprecated flist-plus | sed "s|$(cd .. && pwd)|..|g" > flist.txt

DOCKER_TAIL_COMMAND="hpretl/iic-osic-tools:latest -s make -C /mnt/fpga -f Makefile /mnt/fpga/build/top.json"
docker $DOCKER_ARGS $DOCKER_TAIL_COMMAND

DOCKER_TAIL_COMMAND="regymm/openxc7:latest make -C /mnt/fpga -f Makefile"
docker $DOCKER_ARGS $DOCKER_TAIL_COMMAND
