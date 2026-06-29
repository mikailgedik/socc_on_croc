`include "common_cells/registers.svh"

module ram_muxer#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0,
    
    // We mux multiple 512-rams to one big one
    // DO NOT OVERRIDE
    parameter int UPPER_BITS = ADDRESS_WIDTH - 9,
    // SMALLER_RAMs can be overwritten - will lead to undefined behaviour if upper
    // range is written to
    parameter int SMALLER_RAMS = 1 << UPPER_BITS
) (
    input logic clk_i,
    input logic rst_ni,
    
    input logic [ADDRESS_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] rdata_o,
    input logic [DATA_WIDTH-1:0] wdata_i,
    input logic [DATA_WIDTH/8-1:0] be_i,
    input logic we_i
);
    logic [9-1:0] lower_addr;
    logic [UPPER_BITS-1:0] selected_ram, selected_ram_delayed;
    
    assign lower_addr = addr_i[9-1:0];
    assign selected_ram = addr_i[ADDRESS_WIDTH-1:9];
    `FF(selected_ram_delayed, selected_ram, '0, clk_i, rst_ni)

    // selected_ram_delayed can be 
    logic [SMALLER_RAMS-1:0][DATA_WIDTH-1:0] unmuxed_rdata;
    assign rdata_o = 32'(selected_ram_delayed) < SMALLER_RAMS ? unmuxed_rdata[selected_ram_delayed] : '0;

    genvar i;
    generate
        for(i=0; i < SMALLER_RAMS; i++) begin
            tc_sram_impl #(
                .NumWords  ( 1 << 9 ),
                .DataWidth ( DATA_WIDTH ),
                .NumPorts  (  1 ),
                .Latency   (  1 )
            ) i_sram (
                .clk_i(clk_i),
                .rst_ni(rst_ni),

                .impl_i(),
                .impl_o(),
                .req_i(i == selected_ram),
                .we_i(we_i),
                .addr_i(lower_addr),

                .wdata_i(wdata_i),
                .be_i(be_i),
                .rdata_o(unmuxed_rdata[i])
            );
        end
    endgenerate

endmodule