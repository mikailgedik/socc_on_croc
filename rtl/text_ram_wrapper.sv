module text_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int TOTAL_WORDS = 32'd0
) (
    // TODO reset in sram?
    input logic clk_port0_i,
    input logic [ADDRESS_WIDTH-1:0] port0_address_i,
    output logic [7:0] port0_ascii_o,
    output logic [7:0] port0_color_blink_o,

    input logic clk_port1_i,
    input logic [ADDRESS_WIDTH-1:0] port1_address_i,
    // TODO should the RAM be readable from the OBI bus?
    // output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic port1_we_i
);

// for now, maybe use this: https://github.com/pulp-platform/croc/blob/main/ihp13/tc_sram_impl.sv, or directly
// https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_2P_512x32_c2_bm_bist.v ?

endmodule