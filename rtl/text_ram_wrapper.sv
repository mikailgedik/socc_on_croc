module text_ram_wrapper#(
    parameter int ADDRESS_WIDTH = 32'd0,
    parameter int DATA_WIDTH = 32'd0
) (
    // TODO reset in sram?
    input logic port0_clk_i,
    input logic [ADDRESS_WIDTH-1:0] port0_addr_i,
    output logic [7:0] port0_ascii_o,
    output logic [7:0] port0_color_blink_o,

    input logic port1_clk_i,
    input logic [ADDRESS_WIDTH-1:0] port1_addr_i,
    // TODO should the RAM be readable from the OBI bus?
    // output logic [DATA_WIDTH-1:0] port1_data_o,
    input logic [DATA_WIDTH-1:0] port1_data_i,
    input logic port1_we_i
);

    // for now, maybe use this: https://github.com/pulp-platform/croc/blob/main/ihp13/tc_sram_impl.sv, or directly
    // https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_2P_512x32_c2_bm_bist.v ?

    logic [DATA_WIDTH-1:0] wweeeeeeee [(1 << ADDRESS_WIDTH)-1:0];

    always_ff @(posedge port1_clk_i) begin
        if(port1_we_i) begin
            wweeeeeeee[port1_addr_i] <= port1_data_i;
        end
    end

endmodule