`timescale 1ns / 1ps

module tb_rom_compress;

  //------------------ Structs and Parameters ------------------//
  parameter  T_CLK_HI       = 5ns;                 // set clock high time
  parameter  T_CLK_LO       = 5ns;                 // set clock low time
  localparam T_CLK          = T_CLK_HI + T_CLK_LO; // calculate clock period
  parameter  T_APPL_DEL     = 1ns;                 // set stimuli application delay
  parameter  T_ACQ_DEL      = 5ns;                 // set response aquisition delay

    localparam FF_PER_STAGE = 4096;
    // localparam STAGE_COUNT = 1; // defines latency
    localparam INTS_PER_CLK = (FF_PER_STAGE+31)/32;
  //------------------ Logic Wires ------------------//

  logic       eoc;            // End of computation
  logic       clk;
  logic       rst_n;
  logic enable;

    logic [(INTS_PER_CLK*32-1):0] data_i;
    logic [(INTS_PER_CLK*32-1):0] data_o;
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
    @(negedge clk);
    // Release the reset
    rst_n     = 1'b1;
  end

  //------------------ Design Under Test ------------------//

    test_gen_rom dut_i (
        .clk_i(clk),
        .rst_ni(rst_n),
        .data_i(data_i[(FF_PER_STAGE-1):0]),
        .data_o(data_o[(FF_PER_STAGE-1):0])
    );
  initial begin : basic_test
      eoc = 0;
      $dumpfile("socc_on_croc.vcd");
      $dumpvars(1,i_dut);
      $timeformat(-9, 2, " ns", 20);
        data_i = '0;
      enable = '0;
      @(posedge clk);
      #1;
      enable = '1;

        // TODO
        capture_image("stimuli/ram_init.bin", "output.bin");

      enable = '0;
      eoc = 1;

      // Finish recording the waveform
      $dumpflush;
      $finish(1);
  end

//------------------ Response Check ------------------//
task automatic capture_image(input string stimuli_file, input string result_file);
    int fd;
    int one, clk_cylces;
    byte unsigned file_content[] = new[0];
    int unsigned stimuli[][INTS_PER_CLK];

    fd = $fopen (stimuli_file, "rb");
    if(fd == 0) $error("Could not open file stimuli_file");

    one = $fgetc(fd);
    while (one != -1) begin
        file_content = new[file_content.size() + 1](file_content);
        file_content[file_content.size() -1] = 8'(one & 8'hFF);
        one = $fgetc(fd);
    end

    if(file_content.size() % (INTS_PER_CLK * 4) != 0) begin
        $error("file must have a mutlipe of sizeof(int) * INTS_PER_CLK! %d, %d", file_content.size(), 4 * INTS_PER_CLK);
    end

    stimuli = new[file_content.size()/(INTS_PER_CLK * 4)];
    foreach(stimuli[i]) begin
        foreach(stimuli[i][j]) begin
            int base = 4 * INTS_PER_CLK * i + 4 * j;
            stimuli[i][j] =
                file_content[base] | 
                file_content[base + 1] << 8 |
                file_content[base + 2] << 16 |
                file_content[base + 3] << 24;
        end
    end

    $fclose(fd);
    fd = 0;
    fd = $fopen (result_file, "wb");
    if(fd == 0) $error("Could not open file result_file");


    foreach(stimuli[i]) begin
        #1;
        foreach(stimuli[i][j]) begin
            data_i[j*32 +: 32] = stimuli[i][j];
        end
        $display("Data %d: %x", i, data_i);

        @(posedge clk);
        #1;
        $display("Output: %x", data_o);

        for (int j = 0; j < INTS_PER_CLK; j++) begin
            $fwrite(fd, "%c%c%c%c",
                data_o[j*32 +: 8],
                data_o[j*32 + 8 +: 8],
                data_o[j*32 + 16 +: 8],
                data_o[j*32 + 24 +: 8]);
        end
    end
    $fclose(fd);


endtask //capture_image
endmodule
