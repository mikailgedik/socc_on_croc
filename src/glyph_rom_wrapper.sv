module glyph_rom_wrapper(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int TOTAL_WORDS = 32'd0,
    parameter int MAX_GLYPH_DIMENSION_LOG = 32'd1
) (
    input logic clk_i,
    input logic rst_ni,
    input logic [7:0] ascii_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] x_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] y_i,
    output logic pixel_0
);

endmodule