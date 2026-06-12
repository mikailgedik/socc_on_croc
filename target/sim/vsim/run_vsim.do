vlib work

exec oseda bender script vsim --target vsim > bender_vsim.tcl 2>/dev/null
source bender_vsim.tcl
vopt -work work +acc tb_socc_on_croc -o tb_opt
vsim -lib work tb_opt