`timescale 1ns / 1ps

`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module tb_socc_on_croc;

  //------------------ Structs and Parameters ------------------//
  parameter  T_CLK_HI       = 5ns;                 // set clock high time
  parameter  T_CLK_LO       = 5ns;                 // set clock low time
  localparam T_CLK          = T_CLK_HI + T_CLK_LO; // calculate clock period
  parameter  T_APPL_DEL     = 1ns;                 // set stimuli application delay
  parameter  T_ACQ_DEL      = 5ns;                 // set response aquisition delay

  
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
      capture_image($sformatf("./output-%03x.bmp", 0));

      // capture_image($sformatf("./output-%03x.bmp", 2));
      // capture_image($sformatf("./output-%03x.bmp", 3));
      eoc = 1;

      // Finish recording the waveform
      $dumpflush;
      $finish(1);
  end

  localparam int img_w = 'd800, img_h = 'd525, img_byte_per_pixel = 'd3;
  localparam int img_w_bytes = (img_byte_per_pixel * img_w + 3) / 4 * 4; //Round up each row to 4 bytes
  // pad w to 4 bytes
  localparam int img_file_size = 14 + 40 + img_h * ((img_byte_per_pixel * img_w + 3) / 4 * 4);
  byte header_data [] = {
    8'h42, 8'h4D,
    img_file_size[7:0],
    img_file_size[15:8],
    img_file_size[23:16],
    img_file_size[31:24],
    
    0,0,0,0,
    14+40,0,0,0,
    
    // START DIB (40 byes)
    40,0,0,0,
    img_w[7:0],img_w[15:8],img_w[23:16],img_w[31:24],
    img_h[7:0],img_h[15:8],img_h[23:16],img_h[31:24],
    8'b1,8'b0,    //Color Plane
    8'(img_byte_per_pixel*8),0,   //Bits per Pixel
    0,0,0,0,
    0,0,0,0,
    0,0,0,0,//Pixel per meter
    0,0,0,0,
    0,0,0,0,
    0,0,0,0
  };
  int img_data [img_h][img_w];

  //------------------ Response Check ------------------//
  task automatic capture_image(input string file_name);
      int fd;
      int rgb;
      @(negedge v_sync);
      for(int y = 0; y < img_h; y++) begin
          for(int x = 0; x < img_w; x++) begin
            if(v_sync == 'b0) begin
              img_data[y][x] = 'h7F7F7F;
            end else if (h_sync == 'b0) begin
              img_data[y][x] = 'h0000FF;
            end else begin
              rgb = {
                    8'h00,
                    color[7:5],color[7:5],color[7:6],
                    color[4:2],color[4:2],color[4:3],
                    color[1:0],color[1:0],color[1:0],color[1:0]
                    };
              img_data[y][x] = rgb;
            end

            #(T_CLK);
          end
      end

      fd = $fopen (file_name, "wb");
      if(fd == 0) $error("Could not open file file_name");

      foreach(header_data[i]) begin
          $fwrite(fd, "%c", header_data[i]);
      end

      img_data[0][0] = 'h0000FF; //blue
      img_data[0][1] = 'h00FF00; //green
      img_data[0][2] = 'hFF0000; //red
      
      img_data[img_h - 5][0] = 'hFF0000;
      img_data[0][img_w - 1] = 'h00FF00;
      
      for(int y = img_h - 1; y >= 0; y--) begin
          for(int x = 0; x < img_w; x++) begin
            for(int i = 0; i < img_byte_per_pixel; i++) begin
              $fwrite(fd, "%c", 8'(img_data[y][x] >> (i * 8)));
            end
          end
          // for(int unsigned i = 0; i < img_w_bytes - img_byte_per_pixel * img_w; i++) begin
          //   $fwrite(fd, "%c", 8'b0);
          // end
      end
      $fclose(fd);
  endtask //capture_image
endmodule
