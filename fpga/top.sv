(* blackbox *)
module PLLE2_ADV #(
    parameter BANDWIDTH = "OPTIMIZED",
    parameter COMPENSATION = "ZHOLD",
    parameter STARTUP_WAIT = "FALSE",
    parameter integer DIVCLK_DIVIDE = 1,
    parameter integer CLKFBOUT_MULT = 5,
    parameter integer CLKFBOUT_PHASE = 0.0,
    parameter integer CLKOUT0_DIVIDE = 1,
    parameter integer CLKOUT0_PHASE = 0.0,
    parameter integer CLKOUT0_DUTY_CYCLE = 0.5,
    parameter integer CLKOUT1_DIVIDE = 1,
    parameter integer CLKOUT1_PHASE = 0.0,
    parameter integer CLKOUT1_DUTY_CYCLE = 0.5,
    parameter integer CLKIN1_PERIOD = 0.0
)(
    // Output clocks
    output CLKFBOUT,
    output CLKOUT0,
    output CLKOUT1,
    output CLKOUT2,
    output CLKOUT3,
    output CLKOUT4,
    output CLKOUT5,

    // Input clock control
    input CLKFBIN,
    input CLKIN1,
    input CLKIN2,

    // Clock select
    input CLKINSEL,

    // DRP interface (dynamic reconfiguration)
    input  [6:0]  DADDR,
    input         DCLK,
    input         DEN,
    input  [15:0] DI,
    output [15:0] DO,
    output        DRDY,
    input         DWE,

    // Control/status
    output LOCKED,
    input  PWRDWN,
    input  RST
);
endmodule

module top(
    input logic clk,
    input logic [3:0] btn,
    input logic [3:0] sw,
    output logic [3:0] led,
    output logic [7:0] ja
);
    `include "common_cells/registers.svh"
    
  
    wire        clk_out1_clk_wiz_0;
  wire        clk_out2_clk_wiz_0;
  wire        clk_out3_clk_wiz_0;
  wire        clk_out4_clk_wiz_0;
  wire        clk_out5_clk_wiz_0;
  wire        clk_out6_clk_wiz_0;
  wire        clk_out7_clk_wiz_0;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked;
  wire        clkfbout_clk_wiz_0;
  wire        clkfbout_buf_clk_wiz_0;
  wire        clkfboutb_unused;
   wire clkout2_unused;
   wire clkout3_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  

	wire clk_in1_clk_wiz_0;
	wire clk_in2_clk_wiz_0;
  logic clk_out1, clk_out2;
  logic rst_ni;
    
  always_ff @( posedge clk_in1_clk_wiz_0 ) begin : reset_sync
     rst_ni <= ~btn[0];
  end

  IBUF clkin1_ibufg
   (.O (clk_in1_clk_wiz_0),
    .I (clk));

  BUFG clkf_buf
   (.O (clkfbout_buf_clk_wiz_0),
    .I (clkfbout_clk_wiz_0));

  BUFG clkout1_buf
   (.O   (clk_out1),
    .I   (clk_out1_clk_wiz_0));

  BUFG clkout2_buf
   (.O   (clk_out2),
    .I   (clk_out2_clk_wiz_0));


    (* keep *)
  PLLE2_ADV
  #(
	  .BANDWIDTH            ("OPTIMIZED"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (3),
    .CLKFBOUT_MULT        (37),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE       (49),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT1_DIVIDE       (31),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (10.000)
    )
  plle2_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_clk_wiz_0),
    .CLKOUT0             (clk_out1_clk_wiz_0),
    .CLKOUT1             (clk_out2_clk_wiz_0),
    .CLKOUT2             (clkout2_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_clk_wiz_0),
    .CLKIN1              (clk_in1_clk_wiz_0),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Other control and status signals
    .LOCKED              (locked),
    .PWRDWN              (1'b0),
    .RST                 (~rst_ni));


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

    logic [63:0] cnt_q, cnt_d;
    `FF(cnt_q, cnt_d, 'b0, clk_out1, rst_ni);

    logic [63:0] cnt2_q, cnt2_d;
    `FF(cnt2_q, cnt2_d, 'b0, clk_in1_clk_wiz_0, rst_ni);
    assign cnt2_d = cnt2_q + 'b1;

    // assign led[0] = cnt_q[0] | sw[0];
    assign led[1] = locked;
    assign led[2] = cnt2_q[25];
    assign led[3] = cnt_q[25];

    assign led[0] = rst_ni;
    // assign led[1] = btn[1] ^ sw[1];
    // assign led[2] = btn[2] ^ sw[2];
    // assign led[3] = btn[3] ^ sw[3];


    always_comb begin : color
        cnt_d = cnt_q + 'b1;
        if (last_pixel) begin
            // cnt_d = 'b0;
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
        .clk_i(clk_in1_clk_wiz_0),
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
