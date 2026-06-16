module glyph_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int MAX_GLYPH_DIMENSION_LOG = 32'd4
) (
    // TODO reset in sram?
    input logic clk_i,
    input logic rst_ni,
    input logic [7:0] port0_ascii_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] port0_x_i,
    input logic [MAX_GLYPH_DIMENSION_LOG-1:0] port0_y_i,
    output logic port0_pixel_o,

    input logic [ADDRESS_WIDTH-1:0] port1_addr_i,
    output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic [DATA_WIDTH/8-1:0] port1_be_i,
    input logic port1_we_i
);

    logic [1:0] we;
    logic [1:0][ADDRESS_WIDTH-1:0] addr;
    logic [1:0][DATA_WIDTH-1:0] wdata;
    logic [1:0][DATA_WIDTH/8-1:0] be;
    logic [1:0][DATA_WIDTH-1:0] rdata;

    assign we = {1'h0, port1_we_i};
    assign addr = {(ADDRESS_WIDTH)'(0), port1_addr_i};
    assign wdata = {(DATA_WIDTH)'(0), port1_data_i};
    assign be = {{(DATA_WIDTH/8){1'b1}}, port1_be_i};
    assign port1_data_o = rdata[1];

    // TODO tc_sram_impl vs tc_sram ?
    tc_sram_impl #(
        .NumWords  ( 1 << ADDRESS_WIDTH ),
        .DataWidth ( DATA_WIDTH ),
        .NumPorts  (  2 ),
        .Latency   (  1 )
    ) i_sram (
        .clk_i(clk_i),
        .rst_ni(rst_ni),

        .impl_i(),
        .impl_o(),
        // TODO are we allowed to pull this to high all the time?
        .req_i({1'd1, 1'd1}),
        .we_i(we),
        .addr_i(addr),

        .wdata_i(wdata),
        .be_i(be),
        .rdata_o(rdata)
    );

endmodule