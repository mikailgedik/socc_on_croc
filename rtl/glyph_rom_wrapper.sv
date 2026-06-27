module glyph_rom_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    parameter int GLYPH_WIDTH_LOG = 3,
    parameter int GLYPH_HEIGHT_LOG = 3,
    // derived parameters
    parameter int BITS_PER_GLYPH = (1 << GLYPH_WIDTH_LOG) * (1 << GLYPH_HEIGHT_LOG)
) (
    input logic clk_i,
    input logic rst_ni,
    input logic [7:0] port0_ascii_i,
    input logic [GLYPH_WIDTH_LOG-1:0] port0_x_i,
    input logic [GLYPH_HEIGHT_LOG-1:0] port0_y_i,
    output logic port0_pixel_o
);
    `include "common_cells/registers.svh"

    logic [ADDRESS_WIDTH-1:0] port0_addr;
    logic [$clog2(DATA_WIDTH)-1:0] bit_shift_d, bit_shift_q;
    `FF(bit_shift_q, bit_shift_d, '0, clk_i, rst_ni);

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

    // On clk cycle of latency, since RAM also has one clk cycle latency
    logic [DATA_WIDTH-1:0] rdata_unbuffered, rdata_unbuffered_lower, rdata_unbuffered_upper, rdata;
    `FF(rdata, rdata_unbuffered, '0, clk_i, rst_ni);

    assign port0_pixel_o = rdata[bit_shift_q];
    assign rdata_unbuffered = port0_addr[9] ? rdata_unbuffered_upper : rdata_unbuffered_lower;

    //Font ROM is split, so that the routing is not over-congested
    font_rom_lower# (
        .AddrWidth(ADDRESS_WIDTH + $clog2(DATA_WIDTH / 8)),
        .DataWidth(DATA_WIDTH)
    ) i_font_rom_lower (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .req_i('1),
        .addr_i({port0_addr, ($clog2(DATA_WIDTH / 8))'(1'h0) }),
        .data_o(rdata_unbuffered_lower)
    );

    font_rom_upper# (
        .AddrWidth(ADDRESS_WIDTH + $clog2(DATA_WIDTH / 8)),
        .DataWidth(DATA_WIDTH)
    ) i_font_rom_upper (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .req_i('1),
        .addr_i({port0_addr, ($clog2(DATA_WIDTH / 8))'(1'h0) }),
        .data_o(rdata_unbuffered_upper)
    );
endmodule