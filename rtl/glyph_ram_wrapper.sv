module glyph_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int GLYPH_DIMENSION_LOG = 32'd3, // = clog2(glyph_height) = clog2(glyph_width)
    // derived parameters
    parameter int GLYPH_WIDTH_LOG = GLYPH_DIMENSION_LOG,
    parameter int GLYPH_HEIGHT_LOG = GLYPH_DIMENSION_LOG,
    parameter int BITS_PER_GLYPH = (1 << GLYPH_WIDTH_LOG) * (1 << GLYPH_HEIGHT_LOG)
) (
    // TODO reset in sram?
    input logic clk_i,
    input logic rst_ni,
    input logic [7:0] port0_ascii_i,
    input logic [GLYPH_DIMENSION_LOG-1:0] port0_x_i,
    input logic [GLYPH_DIMENSION_LOG-1:0] port0_y_i,
    output logic port0_pixel_o,

    input logic [ADDRESS_WIDTH-1:0] port1_addr_i,
    output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic [DATA_WIDTH/8-1:0] port1_be_i,
    input logic port1_we_i
);
    `include "common_cells/registers.svh"

    logic [ADDRESS_WIDTH-1:0] port0_addr;
    logic [$clog2(DATA_WIDTH)-1:0] bit_shift_d, bit_shift_q;
    `FF(bit_shift_q, bit_shift_d, '0, clk_i, rst_ni)

    always_comb begin : ascii_to_addr
        localparam int BIT_ADDRESS_WIDTH = ADDRESS_WIDTH + $clog2(DATA_WIDTH);
        logic [BIT_ADDRESS_WIDTH-1:0] bit_address;
        bit_shift_d = 'h0;

        bit_address = (BIT_ADDRESS_WIDTH)'(port0_ascii_i) * (BIT_ADDRESS_WIDTH)'(BITS_PER_GLYPH);
        bit_address += (BIT_ADDRESS_WIDTH)'(port0_y_i * (1 << GLYPH_WIDTH_LOG));
        bit_address += (BIT_ADDRESS_WIDTH)'(port0_x_i);

        bit_shift_d = bit_address[$clog2(DATA_WIDTH) - 1:0];
        port0_addr = bit_address[BIT_ADDRESS_WIDTH-1:$clog2(DATA_WIDTH)];
    end

    assign port0_pixel_o = rdata[0][bit_shift_d];

    logic [1:0] we;
    logic [1:0][ADDRESS_WIDTH-1:0] addr;
    logic [1:0][DATA_WIDTH-1:0] wdata;
    logic [1:0][DATA_WIDTH/8-1:0] be;
    logic [1:0][DATA_WIDTH-1:0] rdata;

    assign we = {port1_we_i, 1'bZ};
    assign addr = {port1_addr_i, port0_addr};
    assign wdata = {port1_data_i, (DATA_WIDTH)'(0)};
    assign be = {port1_be_i, {(DATA_WIDTH/8){1'b1}}};
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