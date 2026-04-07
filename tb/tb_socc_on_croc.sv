`timescale 1ns / 1ps
module tb_socc_on_croc;

  //------------------ Structs and Parameters ------------------//
  parameter  T_CLK_HI       = 5ns;                 // set clock high time
  parameter  T_CLK_LO       = 5ns;                 // set clock low time
  localparam T_CLK          = T_CLK_HI + T_CLK_LO; // calculate clock period
  parameter  T_APPL_DEL     = 1ns;                 // set stimuli application delay
  parameter  T_ACQ_DEL      = 5ns;                 // set response aquisition delay

  parameter RESPONSE_FILE = "./output.bmp";
  parameter RAM_INIT = "./stimuli/Untitled3.data";
  // parameter RAM_INIT = "./stimuli/ram_init.bin";

  // 32bit data, 32bit address
  // stolen from CROC repo, to maximize compatibility...
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

  logic enable;
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
  socc_on_croc #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t),
    .ColorWidthBytes(3)
    ) i_dut (
    .clk_i     (clk       ),
    .rst_ni    (rst_n     ),
    .enable_i(enable),
    .hsync_pol_i('b1),
    .vsync_pol_i('b1),
    
    .obi_req_o (obi_req),
    .obi_rsp_i (obi_rsp),
    


    .h_sync_o(h_sync),
    .v_sync_o(v_sync),
    .color_o(color)
  );

  initial begin : basic_test
      eoc = 0;
      $dumpfile("socc_on_croc.vcd");
      $dumpvars(1,i_dut);
      $timeformat(-9, 2, " ns", 20);
      
      enable = '0;
      init_sram(RAM_INIT);
      // todo there's a weird glitch going on we hold reset down for only one cycle
      // before enabling ? See tb/tmp.sv
      @(posedge clk);
      #1;
      enable = '1;
      save_image(RESPONSE_FILE);
      enable = '0;
      eoc = 1;

      // Finish recording the waveform
      $dumpflush;
      $finish(1);
  end
  localparam logic[31:0] img_w = 'd800, img_h = 'd525, img_byte_per_pixel = 'd3;
  localparam logic[31:0] img_w_bytes = (img_byte_per_pixel * img_w + 3) / 4 * 4; //Round up each row to 4 bytes
  // pad w to 4 bytes
  localparam img_file_size = 14 + 40 + img_h * ((img_byte_per_pixel * img_w + 3) / 4 * 4);
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
  task automatic save_image(input string file_name);
      int fd;
      @(negedge v_sync);
      // TODO Is this aquisition delay correct...?
      #(T_ACQ_DEL);
      for(int y = 0; y < img_h; y++) begin
          for(int x = 0; x < img_w; x++) begin
            if(v_sync == 'b0) begin
              img_data[y][x] = 'hFFFFFF;
            end else if (h_sync == 'b0) begin
              img_data[y][x] = 'h0;
            end else begin
              img_data[y][x] = 32'(color);
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
              $fwrite(fd, "%c", 8'(img_data[y][x] >> (i * 8)));
            end
          end
          for(int i = 0; i < img_w_bytes - img_byte_per_pixel * img_w; i++) begin
            $fwrite(fd, "%c", 8'b0);
          end
      end
      $fclose(fd);
  endtask //save_image

  obi_req_t obi_req;
  obi_rsp_t obi_rsp;
  localparam RAM_SIZE_BYTES = 1 << 21;
  byte data [RAM_SIZE_BYTES];
  
  struct packed {
    logic req_i;
    logic we_i;
    logic [31:0] addr_i;
    logic [31:0] wdata_i;
    logic [3:0] be_i;

    logic gnt_o;
    logic [31:0] rdata_o;
  } sram_shim;

  obi_sram_shim #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t)
    ) i_sram_obi (
    .clk_i(clk),
    .rst_ni(rst_n),

    .obi_req_i(obi_req),
    .obi_rsp_o(obi_rsp),

    .req_o(sram_shim.req_i),
    .we_o(sram_shim.we_i),
    .addr_o(sram_shim.addr_i),
    .wdata_o(sram_shim.wdata_i),
    .be_o(sram_shim.be_i),

    .gnt_i(sram_shim.gnt_o),
    .rdata_i(sram_shim.rdata_o)
  );

  logic active_request_q, active_request_d;
  logic [ObiCfg.AddrWidth-1:0] request_addr_q, request_addr_d;
  
  `FF(active_request_q, active_request_d, 'b0, clk, rst_n);
  `FF(request_addr_q, request_addr_d, 'b0, clk, rst_n);
  
  assign sram_shim.gnt_o = active_request_q;
  
  genvar i;
  generate
    for(i = 0; i < ObiCfg.AddrWidth/8; i++) begin
      assign sram_shim.rdata_o[((i+1)*8-1):(i*8)] = request_addr_q + i < RAM_SIZE_BYTES ? data[request_addr_q + i] : 'haa;
      // assign sram_shim.rdata_o[((i+1)*8-1):(i*8)] = request_addr_q + i;
      // sram_shim.rdata_o[i] = request_addr_q;
    end
  endgenerate

  always_comb begin : sram_backend
    active_request_d = sram_shim.req_i;
    request_addr_d = sram_shim.addr_i;
  end

  task automatic init_sram(input string file_name);
    int fd;
    // Use this in bash to populate the binary file for testing
    // for i in {0..255}; do printf \\x$(printf '%x' $i) >> stimuli/ram_init.bin; done
    int errcode;
    fd = $fopen (file_name, "rb");
    errcode = $fread(data, fd);
    if (errcode == 0) $error("Could not read data, %x", errcode);
    $fclose(fd);
    for(int i = 10; i < 650; i++) begin
      data[4*i] = 8'(i);
      data[4*i+1] = 8'(i >> 8);
      data[4*i+2] = 0;
      data[4*i+3] = 0;
    end
  endtask //automatic

endmodule
