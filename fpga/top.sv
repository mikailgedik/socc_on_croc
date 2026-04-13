module top(
    input logic sys_clk_pin,
    input logic [3:0] sw,
    output logic [3:0] led,
    output logic [7:0] ja,
);
    assign led = sw;

    localparam total_pixels_h = 16'd800;
    localparam active_pixels_h = 16'd640;
    localparam back_porch_h = 16'd48;
    localparam h_sync_width = 16'd96;

    localparam total_pixels_v = 16'd525;
    localparam active_pixels_v = 16'd480;
    localparam back_porch_v = 16'd33;
    localparam v_sync_width = 16'd2;

    localparam hsync_pol_i = 1'b1, vsync_pol_i = 1'b1;
    
    logic consume_one, h_sync, v_sync;
    logic last_pixel;

    logic [20:0] cnt_q, cnt_d;
    `FF(cnt_q, cnt_d, 'b0, sys_clk_pin);

    always_comb begin : color
        cnt_d = cnt_d + 'b1;
        if (last_pixel) begin
            cnt_d = 'b0;
        end
        ja = cnt_q[7:0];
        if(cnt_q < 'd640) ja = 'hFF;
        if(cnt_q < 'd640 * 2) ja = 'h00;
        if(cnt_q < 'd640 * 3) ja = 'hE0;
        if(cnt_q < 'd640 * 4) ja = 'h03;
        if(cnt_q < 'd640 * 5) ja = 'h15;
        ja[2] = h_sync;
        ja[5] = v_sync;
    end

    vga_fsm #(
        .Width(16)
    ) vga_fsm (
        .clk_i(sys_clk_pin),
        .rst_ni(rst_ni),
        .enable_i(sw[0]),

        .max_v_i(total_pixels_v - 'h1),
        .viewable_v_i(active_pixels_v),
        .v_sync_start_i(total_pixels_v - back_porch_v - v_sync_width),
        .v_sync_end_i(total_pixels_v - back_porch_v - 'h1),

        .max_h_i(total_pixels_h - 1),
        .viewable_h_i(active_pixels_h),
        .h_sync_start_i(total_pixels_h - back_porch_h - h_sync_width),
        .h_sync_end_i(total_pixels_h - back_porch_h - 'h1),

        .hsync_pol_i(hsync_pol_i),
        .vsync_pol_i(vsync_pol_i),

        .consume_one_o(consume_one),
        .last_pixel_o(last_pixel),
        .h_sync_o(h_sync),
        .v_sync_o(v_sync)
    );

endmodule