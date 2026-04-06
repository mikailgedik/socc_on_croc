
  /*  32bit data, 32bit address
  stolen from CROC repo
   This is how we would usually define interconnects using the typedef.svh macros
   *
   * `OBI_TYPEDEF_A_CHAN_T(mgr_obi_a_chan_t, MgrObiCfg.AddrWidth, MgrObiCfg.DataWidth, MgrObiCfg.IdWidth, logic [0:0])
   * `OBI_TYPEDEF_DEFAULT_REQ_T(mgr_obi_req_t, mgr_obi_a_chan_t)
   * `OBI_TYPEDEF_R_CHAN_T(mgr_obi_r_chan_t, MgrObiCfg.DataWidth, MgrObiCfg.IdWidth, logic [0:0])
   * `OBI_TYPEDEF_RSP_T(mgr_obi_rsp_t, mgr_obi_r_chan_t)
   *
   * // Create types for OBI subordinates/slaves (out of the interconnect, into the device)
   * localparam obi_pkg::obi_cfg_t SbrObiCfg = obi_pkg::mux_grow_cfg(MgrObiCfg, NumManagers);
   * `OBI_TYPEDEF_A_CHAN_T(sbr_obi_a_chan_t, SbrObiCfg.AddrWidth, SbrObiCfg.DataWidth, SbrObiCfg.IdWidth, logic [0:0])
   * `OBI_TYPEDEF_DEFAULT_REQ_T(sbr_obi_req_t, sbr_obi_a_chan_t)
   * `OBI_TYPEDEF_R_CHAN_T(sbr_obi_r_chan_t, SbrObiCfg.DataWidth, SbrObiCfg.IdWidth, logic [0:0])
   * `OBI_TYPEDEF_RSP_T(sbr_obi_rsp_t, sbr_obi_r_chan_t)
   *
   * // Register Interface configured as 32 bit data, 32 bit address width (4 byte enable bits)
   * `REG_BUS_TYPEDEF_ALL(reg, logic[31:0], logic[31:0], logic[3:0]);
   */

`timescale 1ns / 1ps
module tb_socc_on_croc;

  //------------------ Structs and Parameters ------------------//
  parameter  T_CLK_HI       = 5ns;                 // set clock high time
  parameter  T_CLK_LO       = 5ns;                 // set clock low time
  localparam T_CLK          = T_CLK_HI + T_CLK_LO; // calculate clock period
  parameter  T_APPL_DEL     = 1ns;                 // set stimuli application delay
  parameter  T_ACQ_DEL      = 5ns;                 // set response aquisition delay

  parameter int NUM_VECTOR  = 32;                   // number of vectors in stimuli

  parameter RESPONSE_FILE = "./output.bmp";

    localparam total_pixels_h = 16'd800;
    localparam active_pixels_h = 16'd640;
    localparam back_porch_h = 16'd48;
    localparam h_sync_width = 16'd96;

    localparam total_pixels_v = 16'd525;
    localparam active_pixels_v = 16'd480;
    localparam back_porch_v = 16'd33;
    localparam v_sync_width = 16'd2;


  //------------------ Logic Wires ------------------//

  logic       eoc;            // End of computation

  logic       clk;
  logic       rst_n;


    logic h_sync, v_sync;
    logic [23:0] color;
    
  //------------------ Generate Clock and Reset Signals ------------------//
  initial begin
    // Generating the clock
    do begin
      clk = 1'b1; #T_CLK_HI;
      clk = 1'b0; #T_CLK_LO;
    end while (eoc == 1'b0);
  end

  initial begin
    // Resetting the design for 1 cycle
    rst_n     = 1'b0;
    #(T_CLK);
    // Release the reset
    rst_n     = 1'b1;
    #(T_CLK);
  end

  //------------------ Design Under Test ------------------//
  socc_on_croc #(.Width(24)) i_dut (
    .clk_i     (clk       ),
    .rst_ni    (rst_n     ),
    .obi_req_o (),
    .obi_rsp_i (),
    
    .h_sync_o(h_sync),
    .v_sync_o(v_sync),
    .color_o(color)
  );

initial begin : basic_test
    eoc = 0;
    $dumpfile("socc_on_croc.vcd");
    $dumpvars(1,i_dut);
    
    save_image(RESPONSE_FILE);

    eoc = 1;

    // Finish recording the waveform
    $dumpflush;
    $finish(1);
end
  int fd;
  localparam img_w = 800, img_h = 525, img_byte_per_pixel = 3;
  // pad w to 4 bytes
  localparam img_file_size = 14 + 40 + img_h * ((img_byte_per_pixel * img_w + 3) / 4 * 4);
  int header_data [] = {
    'h42, 'h4D,
    img_file_size & 'hFF,
    (img_file_size >> 8) & 'hFF,
    (img_file_size >> 16) & 'hFF,
    (img_file_size >> 24) & 'hFF,
    
    0,0,0,0,
    14+40,0,0,0,
    
    // START DIB (40 byes)
    40,0,0,0,
    img_w%256,img_w/256,0,0,
    img_h%256,img_h/256,0,0,
    1,0,    //Color Plane
    img_byte_per_pixel*8,0,   //Bits per Pixel
    0,0,0,0,
    0,0,0,0,
    0,0,0,0,//Pixel per meter
    0,0,0,0,
    0,0,0,0,
    0,0,0,0
  };
  int img_data [img_h][img_w];

  //------------------ Response Check ------------------//
  task save_image(input string file_name);
      @(negedge v_sync);
      #(T_ACQ_DEL);
      for(int y = 0; y < img_h; y++) begin
          for(int x = 0; x < img_w; x++) begin
            if(v_sync == 'b0) begin
              img_data[y][x] = 'hFFFFFF;
            end else if (h_sync == 'b0) begin
              img_data[y][x] = 'h0;
            end else begin
              img_data[y][x] = color;
            end

            #(T_CLK);
          end
      end

      fd = $fopen (file_name, "wb");
      if(fd == 0) $error("Could not open file file_name");

      foreach(header_data[i]) begin
          $fwrite(fd, "%c", header_data[i]);
      end

      img_data[0][0] = 'h0000FF;
      img_data[img_h - 5][0] = 'hFF0000;
      img_data[0][img_w - 1] = 'h00FF00;
      
      for(int y = img_h - 1; y >= 0; y--) begin
          for(int x = 0; x < img_w; x++) begin
            for(int i = 0; i < img_byte_per_pixel; i++) begin
              $fwrite(fd, "%c", img_data[y][x] >> (i * 8));
            end
          end
          for(int i = 0; i < (img_byte_per_pixel * img_w + 3) / 4 * 4 - img_byte_per_pixel * img_w; i++) begin
            $fwrite(fd, "%c", 0);
          end
      end
      $fclose(fd);
  endtask //save_image

endmodule