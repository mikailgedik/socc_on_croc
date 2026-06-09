(* blackbox *)
module PLLE2_BASE(CLKFBOUT, CLKOUT0, CLKOUT1, CLKOUT2, CLKOUT3, CLKOUT4, CLKOUT5, LOCKED, CLKFBIN, CLKIN1, PWRDWN, RST);
    parameter BANDWIDTH = "OPTIMIZED";
    parameter integer CLKFBOUT_MULT = 5;
    parameter integer CLKFBOUT_PHASE = 0.000;
    parameter integer CLKIN1_PERIOD = 0.000;
    parameter integer CLKOUT0_DIVIDE = 1;
    parameter integer CLKOUT0_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT0_PHASE = 0.000;
    parameter integer CLKOUT1_DIVIDE = 1;
    parameter integer CLKOUT1_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT1_PHASE = 0.000;
    parameter integer CLKOUT2_DIVIDE = 1;
    parameter integer CLKOUT2_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT2_PHASE = 0.000;
    parameter integer CLKOUT3_DIVIDE = 1;
    parameter integer CLKOUT3_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT3_PHASE = 0.000;
    parameter integer CLKOUT4_DIVIDE = 1;
    parameter integer CLKOUT4_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT4_PHASE = 0.000;
    parameter integer CLKOUT5_DIVIDE = 1;
    parameter integer CLKOUT5_DUTY_CYCLE = 0.500;
    parameter integer CLKOUT5_PHASE = 0.000;
    parameter integer DIVCLK_DIVIDE = 1;
    parameter integer REF_JITTER1 = 0.010;
    parameter STARTUP_WAIT = "FALSE";
    output CLKFBOUT;
    output CLKOUT0;
    output CLKOUT1;
    output CLKOUT2;
    output CLKOUT3;
    output CLKOUT4;
    output CLKOUT5;
    output LOCKED;
    input CLKFBIN;
    input CLKIN1;
    input PWRDWN;
    input RST;
endmodule

(* blackbox *)
module IBUFDS (
    output logic O, 
    input  logic I, 
    input  logic IB
); 
endmodule

(* blackbox *)
module BUFG (
    output logic O, 
    input  logic I
); 
endmodule