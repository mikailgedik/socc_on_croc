module glyph_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int TOTAL_WORDS = 32'd0,
    parameter int MAX_GLYPH_DIMENSION_LOG = 32'd1
) (
    // TODO reset in sram?
    input logic port0_clk_i,
    input logic [7:0] port0_ascii_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] x_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] y_i,
    output logic port0_pixel_0,

    input logic port1_clk_i,
    input logic [ADDRESS_WIDTH-1:0] port1_address_i,
    // TODO should the RAM be readable from the OBI bus?
    // output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic port1_we_i
);

// for now, maybe use this: https://github.com/pulp-platform/croc/blob/main/ihp13/tc_sram_impl.sv, or directly
// https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_2P_512x32_c2_bm_bist.v ?

endmodule