module text_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0
) (
    input logic clk_i,
    input logic rst_ni,
    
    // Since every character is two bytes, the index has a bit more
    input logic [ADDRESS_WIDTH:0] port0_char_index_i,
    output logic [7:0] port0_ascii_o,
    output logic [7:0] port0_color_blink_o,

    input logic [ADDRESS_WIDTH-1:0] port1_addr_i,
    output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic [DATA_WIDTH/8-1:0] port1_be_i,
    input logic port1_en_i,
    input logic port1_we_i
);
    `include "common_cells/registers.svh"

    logic [ADDRESS_WIDTH-1:0] port0_addr;
    logic lower_upper_d, lower_upper_q;
    `FF(lower_upper_q, lower_upper_d, '0, clk_i, rst_ni)

    always_comb begin : ascii_to_addr
        `ifdef VERILATOR
            assert(DATA_WIDTH == 32);
        `endif
        lower_upper_d = port0_char_index_i[0];
        port0_addr = port0_char_index_i[ADDRESS_WIDTH:1];
    end

    
    logic [1:0] we;
    logic [1:0][ADDRESS_WIDTH-1:0] addr;
    logic [1:0][DATA_WIDTH-1:0] wdata;
    logic [1:0][DATA_WIDTH/8-1:0] be;
    logic [DATA_WIDTH-1:0] rdata;

    assign port0_ascii_o = lower_upper_q == 'h0 ? rdata[7:0] : rdata[23:16];
    assign port0_color_blink_o = lower_upper_q == 'h0 ? rdata[15:8] : rdata[31:24];

    assign we = {port1_we_i, 1'b0};
    assign addr = {port1_addr_i, port0_addr};
    assign wdata = {port1_data_i, (DATA_WIDTH)'(0)};
    assign be = {port1_be_i, {(DATA_WIDTH/8){1'b1}}};
    assign port1_data_o = rdata;

    tc_sram_impl #(
        .NumWords  ( 1 << ADDRESS_WIDTH ),
        .DataWidth ( DATA_WIDTH ),
        .NumPorts  (  1 ),
        .Latency   (  1 )
    ) i_sram (
        .clk_i(clk_i),
        .rst_ni(rst_ni),

        .impl_i(),
        .impl_o(),
        .req_i(1'd1),
        .we_i(we[port1_en_i]),
        .addr_i(addr[port1_en_i]),

        .wdata_i(wdata[port1_en_i]),
        .be_i(be[port1_en_i]),
        .rdata_o(rdata)
    );

endmodule