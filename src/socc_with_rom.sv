// Module used so that the FPGA and simulation use same stuff to be comparable
module socc_with_rom(
    input logic clk_i,
    input logic rst_ni,
    input logic enable_i,
    output logic [23:0] color_o,
    output logic hsync_o,
    output logic vsync_o
);
    `include "common_cells/registers.svh"
    `include "obi/typedef.svh"

    localparam obi_pkg::obi_cfg_t ObiCfg = '{
        UseRReady:   1'b0,
        CombGnt:     1'b0,
        AddrWidth:     32,
        DataWidth:     32,
        IdWidth:        1,
        Integrity:   1'b0,
        BeFull:      1'b1,
        OptionalCfg:  '0
    };

    `OBI_TYPEDEF_A_CHAN_T(obi_a_chan_t, ObiCfg.AddrWidth, ObiCfg.DataWidth, ObiCfg.IdWidth, logic [0:0])
    `OBI_TYPEDEF_DEFAULT_REQ_T(obi_req_t, obi_a_chan_t)
    `OBI_TYPEDEF_R_CHAN_T(obi_r_chan_t, ObiCfg.DataWidth, ObiCfg.IdWidth, logic [0:0])
    `OBI_TYPEDEF_RSP_T(obi_rsp_t, obi_r_chan_t)

    obi_req_t obi_req;
    obi_rsp_t obi_rsp;

    localparam total_pixels_h = 16'd800;
    localparam active_pixels_h = 16'd640;
    localparam back_porch_h = 16'd48;
    localparam h_sync_width = 16'd96;

    localparam total_pixels_v = 16'd525;
    localparam active_pixels_v = 16'd480;
    localparam back_porch_v = 16'd33;
    localparam v_sync_width = 16'd2;

    localparam hsync_pol_i = 1'b1, vsync_pol_i = 1'b1;
    
    logic [7:0] color;

    socc_on_croc #(
        .ObiCfg(ObiCfg),
        .obi_req_t(obi_req_t),
        .obi_rsp_t(obi_rsp_t),
        .ColorWidthBytes(1)
    ) i_socc_on_croc (
        .clk_i     (clk_i),
        .rst_ni    (rst_ni),
        .enable_i(enable_i),
        .hsync_pol_i(hsync_pol_i),
        .vsync_pol_i(vsync_pol_i),

        .obi_req_o (obi_req),
        .obi_rsp_i (obi_rsp),

        .h_sync_o(hsync_o),
        .v_sync_o(vsync_o),
        .color_o(color)
    );

    logic mem_req;
    logic [ObiCfg.AddrWidth-1:0] mem_addr;
    logic [ObiCfg.AddrWidth-1:0] rom_buffer_q,rom_buffer_d;
    obi_sram_shim #(
        .ObiCfg(ObiCfg),
        .obi_req_t(obi_req_t),
        .obi_rsp_t(obi_rsp_t)
    ) i_sram_obi (
        .clk_i(clk_i),
        .rst_ni(rst_ni),

        .obi_req_i(obi_req),
        .obi_rsp_o(obi_rsp),

        .req_o(mem_req),
        .we_o(),
        .addr_o(mem_addr),
        .wdata_o(),
        .be_o(),

        .gnt_i('1),
        .rdata_i(rom_buffer_q)
    );

    assign color_o = {
        8'h00,
        color[7:5], color[7:5], color[7:6],
        color[4:2], color[4:2], color[4:3],
        color[1:0], color[1:0], color[1:0],color[1:0]
    };

    // SRAM shim expects one clk cycle latency
    `FF(rom_buffer_q, rom_buffer_d, '0, clk_i, rst_ni);
    
    rom_8bit #(
    .AddrWidth(ObiCfg.AddrWidth),
    .DataWidth(ObiCfg.DataWidth)
    ) i_rom (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .req_i(),
        .addr_i(mem_addr),
        .data_o(rom_buffer_d)
    );

endmodule