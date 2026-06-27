module glyph_ram_wrapper#(
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
    output logic port0_pixel_o,

    input logic [ADDRESS_WIDTH-1:0] port1_addr_i,
    output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic [DATA_WIDTH/8-1:0] port1_be_i,
    input logic port1_en_i,
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


    logic [1:0] we;
    logic [1:0][ADDRESS_WIDTH-1:0] addr;
    logic [1:0][DATA_WIDTH-1:0] wdata;
    logic [1:0][DATA_WIDTH/8-1:0] be;
    logic [DATA_WIDTH-1:0] rdata;

    assign port0_pixel_o = rdata[bit_shift_q];

    assign we = {port1_we_i, 1'b0};
    assign addr = {port1_addr_i, port0_addr};
    assign wdata = {port1_data_i, (DATA_WIDTH)'(0)};
    assign be = {port1_be_i, {(DATA_WIDTH/8){1'b1}}};
    assign port1_data_o = rdata;

    ram_muxer #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
         // instantiate only 2 instead of 4, since 32Ki bits are enough
        .SMALLER_RAMS(2)
    ) i_ram_muxer (
        .clk_i(clk_i),
        .rst_ni(rst_ni),

        .we_i(we[port1_en_i]),
        .addr_i(addr[port1_en_i]),

        .wdata_i(wdata[port1_en_i]),
        .be_i(be[port1_en_i]),
        .rdata_o(rdata)
    );
endmodule