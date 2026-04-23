
module top(
    input logic clk,
    input logic [3:0] btn,
    input logic [3:0] sw,
    output logic [3:0] led,
    output logic [7:0] ja,
    output logic [7:0] je
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

    logic clk1, clk2, rst1_n, rst2_n, pll_locked;

    logic [63:0] cnt1_d, cnt1_q, cnt2_d, cnt2_q;
    logic h_sync, v_sync;
    logic enable_q, enable_d;
    logic [15:0] enable_cnt_q, enable_cnt_d;

    logic [7:0] color;
    obi_req_t obi_req;
    obi_rsp_t obi_rsp;

    plle2_adv i_pll (
        .clk(clk),
        .clk_out1(clk2),
        .clk_out2(clk1),
        .locked(pll_locked),
        .reset(btn[0])
    );
    
    always_ff @( posedge clk1 ) begin : reset_sync1
        rst1_n <= ~btn[0];
    end
    always_ff @( posedge clk2 ) begin : reset_sync2
        rst2_n <= ~btn[0];
    end

    `FF(cnt1_q, cnt1_d, 'b0, clk1, rst1_n);
    `FF(cnt2_q, cnt2_d, 'b0, clk2, rst2_n);
    `FF(enable_q, enable_d, 'b0, clk1, rst1_n);
    `FF(enable_cnt_q, enable_cnt_d, 'b0, clk1, rst1_n);
    
    // assign cnt1_d = cnt1_q + 'b1;
    assign cnt2_d = cnt2_q + 'b1;

    assign led[0] = rst1_n;
    assign led[1] = pll_locked;
    assign led[2] = enable_q;
    assign led[3] = cnt1_q[25];

    assign je[0] = h_sync;
    assign je[1] = v_sync;

    assign je[4] = color[3]; // g
    assign je[5] = color[4];

    assign je[2] = color[0]; // b
    assign je[6] = color[1];

    assign je[3] = color[6]; // r
    assign je[7] = color[7];

    always_comb begin : counter_thing
        cnt1_d = cnt1_q - 'b1;
        if(cnt1_q == 'b0) cnt1_d = 'd4199999;
    end
    
    always_comb begin : enable_debounce
        enable_d = enable_q;
        enable_cnt_d = enable_cnt_q;
        if (sw[0] == 'b1) begin
            if (enable_cnt_q == '1) begin enable_d = 'b1; end
            else begin enable_cnt_d = enable_cnt_q + 'b1; end
        end else begin
            if (enable_cnt_q == 'b0) begin enable_d = 'b0; end
            else begin enable_cnt_d = enable_cnt_q - 'b1; end
        end
    end

    localparam total_pixels_h = 16'd800;
    localparam active_pixels_h = 16'd640;
    localparam back_porch_h = 16'd48;
    localparam h_sync_width = 16'd96;

    localparam total_pixels_v = 16'd525;
    localparam active_pixels_v = 16'd480;
    localparam back_porch_v = 16'd33;
    localparam v_sync_width = 16'd2;

    localparam hsync_pol_i = 1'b1, vsync_pol_i = 1'b1;
    
    socc_on_croc #(
        .ObiCfg(ObiCfg),
        .obi_req_t(obi_req_t),
        .obi_rsp_t(obi_rsp_t),
        .ColorWidthBytes(1)
    ) i_dut (
        .clk_i     (clk1),
        .rst_ni    (rst1_n),
        .enable_i(enable_q),
        .hsync_pol_i(hsync_pol_i),
        .vsync_pol_i(vsync_pol_i),

        .obi_req_o (obi_req),
        .obi_rsp_i (obi_rsp),

        .h_sync_o(h_sync),
        .v_sync_o(v_sync),
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
        .clk_i(clk1),
        .rst_ni(rst1_n),

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

    // SRAM shim expects one clk cycle latency
    `FF(rom_buffer_q, rom_buffer_d, '0, clk1, rst1_n);
    assign rom_buffer_d = '0;
    // rom_8bit_counter #(
    // .AddrWidth(ObiCfg.AddrWidth),
    // .DataWidth(ObiCfg.DataWidth)
    // ) i_rom (
    //     .clk_i(clk1),
    //     .rst_ni(rst1_n),
    //     .req_i(),
    //     .addr_i(mem_addr),
    //     .data_o(rom_buffer_d)
    // );

endmodule
