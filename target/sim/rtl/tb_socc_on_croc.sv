`timescale 1ns / 1ps

`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module tb_socc_on_croc;
  import socc_on_croc_utils_pkg::DelayImpl;
  //------------------ Structs and Parameters ------------------//
  localparam time T_CLK_HI       = 5ns;                 // set clock high time
  localparam time T_CLK_LO       = 5ns;                 // set clock low time
  localparam time T_CLK          = T_CLK_HI + T_CLK_LO; // calculate clock period
  localparam time T_APPL_DEL     = 1ns;                 // set stimuli application delay
  localparam time T_ACQ_DEL      = 5ns;                 // set response aquisition delay

  
  //------------------ Logic Wires ------------------//

  logic       eoc;            // End of computation
  logic       clk;
  logic       rst_n;
  logic h_sync, v_sync;
  logic [7:0] color;
  logic obi_done;

  //------------------ Generate Clock and Reset Signals ------------------//
  initial begin
    // Generating the clock and reset
    rst_n = 1'b0;
    clk = 1'b1;
    #T_CLK_HI;
    clk = 1'b0;
    rst_n = 1'b1;
    #T_CLK_LO;
    do begin
      clk = 1'b1;
      #T_CLK_HI;
      clk = 1'b0;
      #T_CLK_LO;
    end while (eoc == 1'b0);
  end

  //------------------ Design Under Test ------------------//
  obi_tester #(
  ) i_dut (
    .clk_i (clk       ),
    .rst_ni    (rst_n     ),
    
    .hsync_o(h_sync),
    .vsync_o(v_sync),
    .color_o(color),
    .obi_done(obi_done)
  );

  initial begin : basic_test
      eoc = 0;
      $dumpfile("socc_on_croc.vcd");
      $dumpvars(1,i_dut);
      $timeformat(-9, 2, " ns", 20);
      
      #1;
      wait (obi_done == '1);
      DelayImpl#(.T_CLK(T_CLK))::capture_image($sformatf("./output-%03x.bmp", 0), color, h_sync, v_sync);

      eoc = 1;

      // Finish recording the waveform
      $dumpflush;
      $finish(1);
  end
endmodule
