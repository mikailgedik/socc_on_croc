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

module plle2_adv(
    input logic clk,
    output logic clk_out1,
    output logic clk_out2,
    output logic locked,
    input logic reset
);
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

    logic reset_internal;
    always_ff @( posedge clk_in1_clk_wiz_0 ) begin : blockName
        reset_internal <= reset;
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
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT        (8),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE       (25),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT1_DIVIDE       (40),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (8.000)
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
    .RST                 (reset_internal));
endmodule