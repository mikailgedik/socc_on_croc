`timescale 1ns / 1ps

`define FF(__q, __d, __reset_value, __clk = `REG_DFLT_CLK, __arst_n = `REG_DFLT_RST) \
  always_ff @(posedge (__clk) or negedge (__arst_n)) begin                           \
    if (!__arst_n) begin                                                             \
      __q <= (__reset_value);                                                        \
    end else begin                                                                   \
      __q <= (__d);                                                                  \
    end                                                                              \
  end

module genesys2_top (
    // Genesys 2 200MHz differential clock
    input  logic sysclk_p, 
    input  logic sysclk_n, 
    
    // Active high reset
    input  logic btnc,     

    // Switch
    input logic sw,
    
    // VGA Connector output pins
    output logic [4:0] vga_r,
    output logic [5:0] vga_g,
    output logic [4:0] vga_b,
    output logic vga_hs,
    output logic vga_vs,
    
    output logic led[2:0]
);

logic rst_ni;
assign rst_ni = ~btnc;

logic clk_200_se;     // Single-ended 200MHz clock
logic clk_vga_unbuf;  // 25.2MHz straight out of PLL
logic clk_vga;        // 25.2MHz buffered (ready to use)
logic clk_fb;         // Feedback loop for PLL
logic locked;         // HIGH when clock is stable

// Differential Input to Single-Ended
IBUFDS clk_ibuf (
    .I(sysclk_p),
    .IB(sysclk_n),
    .O(clk_200_se)
);

// Kintex-7 PLL Base Primitive (Cleaner, no DRP ports)
PLLE2_BASE #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKIN1_PERIOD(5.000),      // 200 MHz = 5.0 ns period
    .DIVCLK_DIVIDE(10),         // D = 10
    .CLKFBOUT_MULT(63),         // M = 63 
    .CLKOUT0_DIVIDE(50)         // O = 50 (Yields exactly 25.2 MHz)
) pll_inst (
    // Clock in and Feedback
    .CLKIN1(clk_200_se),
    .CLKFBIN(clk_fb),           // Connect feedback out to feedback in
    
    // Control and Status
    .RST(btnc),                 // Reset signal
    .PWRDWN(1'b0),              // Do not power down
    .LOCKED(locked),            // Status flag

    // Clock Outputs
    .CLKOUT0(clk_vga_unbuf),    // Our target 25.2 MHz clock
    .CLKFBOUT(clk_fb),          // Feedback out
    
    // Unconnected Clock Outputs (Explicitly empty to silence warnings)
    .CLKOUT1(),
    .CLKOUT2(),
    .CLKOUT3(),
    .CLKOUT4(),
    .CLKOUT5()
);

BUFG bufg_inst (
    .I(clk_vga_unbuf),
    .O(clk_vga)
);


// CONFIGURATION
logic config_blink_en;
assign config_blink_en = sw;





// ==========================================
// (1) VGA Sync Generation 
// ==========================================

logic s1_hs;
logic s1_vs;
logic [9:0] s1_hpos;
logic [9:0] s1_vpos;
logic s1_visible;

hvsync_generator hvsync_gen(
    .clk_i(clk_vga),
    .rst_ni(~btnc),
    .enable_i(1'b1),
    .hsync_o(s1_hs),
    .vsync_o(s1_vs),
    .visible_o(s1_visible),
    .hpos_o(s1_hpos),
    .vpos_o(s1_vpos)
);

//blinker
logic [4:0] s1_blink_char_counter, blink_char_counter;
logic s1_blink_state, blink_state; // 1 = show text, 0 = hide text
assign led[2] = blink_state;

`FF(s1_blink_char_counter, blink_char_counter, '0, clk_vga, rst_ni);
`FF(s1_blink_state, blink_state, '0, clk_vga, rst_ni);

logic vsync_detector;
`FF(vsync_detector, s1_vs, '0, clk_vga, rst_ni);


always_comb begin
    blink_char_counter = s1_blink_char_counter;
    blink_state = s1_blink_state;
    if (vsync_detector && !s1_vs) begin 
        blink_char_counter = s1_blink_char_counter + 1;
        if (blink_char_counter == 5'd31) begin
                    blink_char_counter = 0;
                    blink_state = ~s1_blink_state;
        end
    end
end


// ==========================================
// (2) Text RAM
// ==========================================



logic [11:0] text_ram_addr;
logic [15:0] text_ram_data;

logic s2_hs;
logic s2_vs;
logic [9:0] s2_hpos;
logic [9:0] s2_vpos;
logic s2_visible;
logic s2_blink_state;
logic [15:0] s2_text_ram_data;

(* ram_style = "block" *) logic [15:0] text_ram [0:4095];

initial begin
    // Fill screen with Blue Background (0x1) and White Foreground (0xF) space character (0x20)
    text_ram = '{default: 16'h1F20};
    
    // Draw "VGA TEXT MODE" centered in yellow (0xE) on dark blue (0x1) background
    text_ram[14*80 + 33] = 16'h1E56; // V
    text_ram[14*80 + 34] = 16'h1E47; // G
    text_ram[14*80 + 35] = 16'h1E41; // A
    text_ram[14*80 + 36] = 16'h1E20; // 
    text_ram[14*80 + 37] = 16'h9E54; // T (Blinking!)
    text_ram[14*80 + 38] = 16'h9E45; // E (Blinking!)
    text_ram[14*80 + 39] = 16'h9E58; // X (Blinking!)
    text_ram[14*80 + 40] = 16'h9E54; // T (Blinking!)
    text_ram[14*80 + 41] = 16'h1E20; // 
    text_ram[14*80 + 42] = 16'h1E4D; // M
    text_ram[14*80 + 43] = 16'h1E4F; // O
    text_ram[14*80 + 44] = 16'h1E44; // D
    text_ram[14*80 + 45] = 16'h1E45; // E
    text_ram[14*80 + 46] = 16'h1E20; // 
    text_ram[14*80 + 47] = 16'h1E01; // 
    text_ram[14*80 + 48] = 16'h1E02; // 
    text_ram[14*80 + 49] = 16'h1E7F;
    text_ram[14*80 + 49] = 16'h1EF4;
    text_ram[15*80 + 49] = 16'h1EF5;

    // Rainbow
    text_ram[17*80 + 10] = 16'h0F20;
    text_ram[17*80 + 11] = 16'h1F20;
    text_ram[17*80 + 12] = 16'h2F20;
    text_ram[17*80 + 13] = 16'h3F20;
    text_ram[17*80 + 14] = 16'h4F20;
    text_ram[17*80 + 15] = 16'h5F20;
    text_ram[17*80 + 16] = 16'h6F20;
    text_ram[17*80 + 17] = 16'h7F20;
    text_ram[17*80 + 18] = 16'h8F20;
    text_ram[17*80 + 19] = 16'h9F20;
    text_ram[17*80 + 20] = 16'hAF20;
    text_ram[17*80 + 21] = 16'hBF20;
    text_ram[17*80 + 22] = 16'hCF20;
    text_ram[17*80 + 23] = 16'hDF20;
    text_ram[17*80 + 24] = 16'hEF20;
    text_ram[17*80 + 25] = 16'hFF20;


end

assign text_ram_addr = (s1_vpos[9:4] * 80) + s1_hpos[9:3];
assign text_ram_data = text_ram[text_ram_addr];

`FF(s2_hs, s1_hs, '0, clk_vga, rst_ni);
`FF(s2_vs, s1_vs, '0, clk_vga, rst_ni);
`FF(s2_hpos, s1_hpos, '0, clk_vga, rst_ni);
`FF(s2_vpos, s1_vpos, '0, clk_vga, rst_ni);
`FF(s2_visible, s1_visible, '0, clk_vga, rst_ni);
`FF(s2_blink_state, s1_blink_state, '0, clk_vga, rst_ni);
`FF(s2_text_ram_data, text_ram_data, '0, clk_vga, rst_ni);


// ==========================================
// (3) Glyph ROM (& RAM later)
// ==========================================

logic [7:0] char_code;
assign char_code = s2_text_ram_data[7:0];

logic [3:0] row;
assign row = s2_vpos[3:0];

logic [7:0] font_data;

font_rom cl_font_rom (
    .char_code(char_code),
    .row(row),
    .font_data(font_data)
);

logic s3_hs;
logic s3_vs;
logic [9:0] s3_hpos;
logic [9:0] s3_vpos;
logic s3_visible;
logic s3_blink_state;
logic [15:0] s3_text_ram_data;
logic [7:0] s3_font_data;

`FF(s3_hs, s2_hs, '0, clk_vga, rst_ni);
`FF(s3_vs, s2_vs, '0, clk_vga, rst_ni);
`FF(s3_hpos, s2_hpos, '0, clk_vga, rst_ni);
`FF(s3_vpos, s2_vpos, '0, clk_vga, rst_ni);
`FF(s3_visible, s2_visible, '0, clk_vga, rst_ni);
`FF(s3_blink_state, s2_blink_state, '0, clk_vga, rst_ni);
`FF(s3_text_ram_data, s2_text_ram_data, '0, clk_vga, rst_ni);
`FF(s3_font_data, font_data, '0, clk_vga, rst_ni);


// ==========================================
// (4) Color decoding and output
// ==========================================

logic [3:0] internal_r;
logic [3:0] internal_g;
logic [3:0] internal_b;

logic pixel_bit;
assign pixel_bit = s3_font_data[3'h7 - s3_hpos[2:0]];

logic [3:0] fg_color;
assign fg_color = s3_text_ram_data[11:8];

logic [3:0] bg_color;
// assign bg_color = s3_text_ram_data[15:12]; // remove bc of blink logic

logic char_blink_en;
always_comb begin
    if (config_blink_en) begin
        bg_color      = {1'b0, s3_text_ram_data[14:12]};
        char_blink_en = s3_text_ram_data[15];
    end else begin
        bg_color      = s3_text_ram_data[15:12];
        char_blink_en = 1'b0;
    end
end

logic show_fg;
assign show_fg = pixel_bit & ~(char_blink_en & ~blink_state);

logic [3:0] final_color;
assign final_color = show_fg ? fg_color : bg_color;



always_comb begin
    if (s3_visible) begin
        internal_r = final_color[2] ? (final_color[3] ? 4'hF : 4'hA) : (final_color[3] ? 4'h5 : 4'h0);
        internal_g = final_color[1] ? (final_color[3] ? 4'hF : 4'hA) : (final_color[3] ? 4'h5 : 4'h0);
        internal_b = final_color[0] ? (final_color[3] ? 4'hF : 4'hA) : (final_color[3] ? 4'h5 : 4'h0);

        // Exception for CGA Brown (Dark Yellow index 6)
        if (final_color == 4'h6) begin
            internal_r = 4'hA;
            internal_g = 4'h5;
            internal_b = 4'h0;
        end
    end else begin
        internal_r = 4'h0;
        internal_g = 4'h0;
        internal_b = 4'h0;
    end
end

logic s4_hs;
logic s4_vs;

logic [3:0] s4_r;
logic [3:0] s4_g;
logic [3:0] s4_b;

`FF(s4_hs, s3_hs, '0, clk_vga, rst_ni);
`FF(s4_vs, s3_vs, '0, clk_vga, rst_ni);
`FF(s4_r, internal_r, '0, clk_vga, rst_ni);
`FF(s4_g, internal_g, '0, clk_vga, rst_ni);
`FF(s4_b, internal_b, '0, clk_vga, rst_ni);



// 4-4-4 to 5-6-5 conversion
assign vga_r = {s4_r, s4_r[3]}; 
assign vga_g = {s4_g, s4_g[3:2]}; 
assign vga_b = {s4_b, s4_b[3]};
assign vga_hs = s4_hs;
assign vga_vs = s4_vs;


// ==========================================
// LED Debug
// ==========================================
logic [30:0] blink_counter_q, blink_counter_d;

always_comb begin
    blink_counter_d = blink_counter_q + 1;

    if (blink_counter_q >= 'd252000000) begin
        blink_counter_d = '0;
    end

end

always_ff @( posedge clk_vga ) begin
    if (btnc == 1'b1) begin
        blink_counter_q <= '0;
    end else begin
        blink_counter_q <= blink_counter_d;
    end
end

assign led[0] = blink_counter_q < ('d252000000)/2;
assign led[1] = btnc;


endmodule