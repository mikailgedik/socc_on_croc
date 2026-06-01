set_property PACKAGE_PIN AD11 [get_ports sysclk_n]
set_property IOSTANDARD LVDS [get_ports sysclk_n]

set_property PACKAGE_PIN AD12 [get_ports sysclk_p]
set_property IOSTANDARD LVDS [get_ports sysclk_p]

create_clock -add -name sys_clk_pin -period 5.000 -waveform {0 2.500} [get_ports sysclk_p]

set_property PACKAGE_PIN E18 [get_ports btnc]
set_property IOSTANDARD LVCMOS12 [get_ports btnc]

# VGA
set_property PACKAGE_PIN AH20 [get_ports vga_b[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b[0]]

set_property PACKAGE_PIN AG20 [get_ports vga_b[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b[1]]

set_property PACKAGE_PIN AF21 [get_ports vga_b[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b[2]]

set_property PACKAGE_PIN AK20 [get_ports vga_b[3]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b[3]]

set_property PACKAGE_PIN AG22 [get_ports vga_b[4]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_b[4]]

set_property PACKAGE_PIN AJ23 [get_ports vga_g[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[0]]

set_property PACKAGE_PIN AJ22 [get_ports vga_g[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[1]]

set_property PACKAGE_PIN AH22 [get_ports vga_g[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[2]]

set_property PACKAGE_PIN AK21 [get_ports vga_g[3]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[3]]

set_property PACKAGE_PIN AJ21 [get_ports vga_g[4]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[4]]

set_property PACKAGE_PIN AK23 [get_ports vga_g[5]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_g[5]]

set_property PACKAGE_PIN AK25 [get_ports vga_r[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r[0]]

set_property PACKAGE_PIN AG25 [get_ports vga_r[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r[1]]

set_property PACKAGE_PIN AH25 [get_ports vga_r[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r[2]]

set_property PACKAGE_PIN AK24 [get_ports vga_r[3]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r[3]]

set_property PACKAGE_PIN AJ24 [get_ports vga_r[4]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_r[4]]

set_property PACKAGE_PIN AF20 [get_ports vga_hs]
set_property IOSTANDARD LVCMOS33 [get_ports vga_hs]

set_property PACKAGE_PIN AG23 [get_ports vga_vs]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vs]

# LED
set_property PACKAGE_PIN T28 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]

set_property PACKAGE_PIN V19 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]

set_property PACKAGE_PIN U30 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]

# Switches
set_property PACKAGE_PIN G19 [get_ports sw]
set_property IOSTANDARD LVCMOS12 [get_ports sw]