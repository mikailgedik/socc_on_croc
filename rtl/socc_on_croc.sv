`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module socc_on_croc  #(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic,
  parameter bit[ObiCfg.AddrWidth-1:0] OBI_ADDRESS_OFFSET = '0,

  // Horizontal timing parameters (in pixels)
  parameter int H_ACTIVE = 640,       // Display width
  parameter int H_BACK_PORCH = 48,    // Left border
  parameter int H_FRONT_PORCH = 16,   // Right border
  parameter int H_SYNC_WIDTH = 96,    // Sync pulse width

  // Vertical timing parameters (in lines)
  parameter int V_ACTIVE = 480,       // Display height
  parameter int V_BACK_PORCH = 33,    // Top border
  parameter int V_FRONT_PORCH = 10,   // Bottom border
  parameter int V_SYNC_WIDTH = 2,     // Sync pulse width (in lines)

  parameter int GLYPH_WIDTH_LOG = 3,
  parameter int GLYPH_HEIGHT_LOG = 4
) (
  // clk_vga must be a multiple of clk_obi, or clk_obi
  input logic clk_i,
  input logic rst_ni,

  input obi_req_t obi_req_i,
  output obi_rsp_t obi_rsp_o,
  output logic hsync_o,
  output logic vsync_o,
  output logic [7:0] color_o
);
  `include "common_cells/registers.svh"

  localparam int RAM_ADDR_WIDTH = 'd11;

  localparam COUNTER_WIDTH = 10;
  logic hsync_unbuffered, vsync_unbuffered, output_visible_unbuffered;
  logic [COUNTER_WIDTH-1:0] screen_x, screen_y;

  logic [3:0] clk_divider;
  logic clk_enable;
  logic [3:0] clk_counter_q, clk_counter_d;
  `FF(clk_counter_q, clk_counter_d, '1, clk_i, rst_ni);
  assign clk_counter_d = clk_counter_q == clk_divider ? 'h0 : clk_counter_q + 'h1;
  assign clk_enable = clk_counter_q == 'h0;

  sync_generator #(
    .COUNTER_WIDTH(COUNTER_WIDTH),

    .H_ACTIVE(H_ACTIVE),
    .H_BACK_PORCH(H_BACK_PORCH),
    .H_FRONT_PORCH(H_FRONT_PORCH),
    .H_SYNC_WIDTH(H_SYNC_WIDTH),

    .V_ACTIVE(V_ACTIVE),
    .V_BACK_PORCH(V_BACK_PORCH),
    .V_FRONT_PORCH(V_FRONT_PORCH),
    .V_SYNC_WIDTH(V_SYNC_WIDTH)
  ) i_sync_generator (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .clk_enable_i(clk_enable),

    .hsync_o(hsync_unbuffered),
    .vsync_o(vsync_unbuffered),
    .visible_o(output_visible_unbuffered),
    .hpos_o(screen_x),
    .vpos_o(screen_y)
  );

  logic [RAM_ADDR_WIDTH:0] character_index;
  address_generator #(
    .COUNTER_WIDTH(COUNTER_WIDTH),
    .GLYPH_WIDTH_BITS(1 << GLYPH_WIDTH_LOG),
    .GLYPH_HEIGHT_BITS(1 << GLYPH_HEIGHT_LOG),
    .PIXELS_PER_ROW(H_ACTIVE),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH)
  ) i_address_generator (
    .screen_x(screen_x),
    .screen_y(screen_y),
    .character_index_o(character_index)
  );

  logic [RAM_ADDR_WIDTH-1:0] ram_addr;
  logic [ObiCfg.DataWidth-1:0] ram_data;
  logic [1:0][ObiCfg.DataWidth-1:0] ram_data_output;
  logic [(ObiCfg.DataWidth/8)-1:0]ram_be;
  logic ram_we;
  logic ram_selector;

  logic blink_disable;
  logic [7:0] color_palette [15:0];
  logic enable_glyph_ram;

  obi_sub #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .OBI_ADDRESS_OFFSET(OBI_ADDRESS_OFFSET)
  ) i_obi_sub(
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .obi_req_i(obi_req_i),
    .obi_rsp_o(obi_rsp_o),

    .color_palette_o(color_palette),
    .clk_divider_o(clk_divider),
    .disable_blink_o(blink_disable),
    .enable_glyph_ram_o(enable_glyph_ram),

    .ram_addr_o(ram_addr),
    .ram_data_o(ram_data),
    .ram_be_o(ram_be),
    .ram_data_i(ram_data_output),
    .ram_we_o(ram_we),
    .ram_selector_o(ram_selector)
  );

  logic [7:0] ascii_char;
  logic [7:0] color_blink;

  text_ram_wrapper #(
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH),
    .DATA_WIDTH(ObiCfg.DataWidth)
  ) i_text_ram (
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .port0_char_index_i(character_index),
    .port0_ascii_o(ascii_char),
    .port0_color_blink_o(color_blink),

    .port1_addr_i(ram_addr),
    .port1_data_o(ram_data_output[0]),
    .port1_data_i(ram_data),
    .port1_be_i(ram_be),
    .port1_we_i(ram_we && (ram_selector == 'd0))
  );

  logic one_bit_pixel, one_bit_pixel_rom, one_bit_pixel_ram;
  assign one_bit_pixel = enable_glyph_ram ? one_bit_pixel_ram : one_bit_pixel_rom;

  // Delayed by one clk cylce, since text RAM adds 1 latency
  logic [GLYPH_WIDTH_LOG-1:0] glyph_x;
  logic [GLYPH_HEIGHT_LOG-1:0] glyph_y;
  `FF(glyph_x, screen_x[GLYPH_WIDTH_LOG-1:0], 'h0, clk_i, rst_ni);
  `FF(glyph_y, screen_y[GLYPH_HEIGHT_LOG-1:0], 'h0, clk_i, rst_ni);

  glyph_ram_wrapper #(
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH),
    .DATA_WIDTH(ObiCfg.DataWidth),
    .GLYPH_WIDTH_LOG(GLYPH_WIDTH_LOG),
    .GLYPH_HEIGHT_LOG(GLYPH_HEIGHT_LOG)
  ) i_glyph_ram (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    
    .port0_ascii_i(ascii_char),
    .port0_x_i(glyph_x),
    .port0_y_i(glyph_y),
    .port0_pixel_o(one_bit_pixel_ram),

    .port1_addr_i(ram_addr),
    .port1_data_o(ram_data_output[1]),
    .port1_data_i(ram_data),
    .port1_be_i(ram_be),
    .port1_we_i(ram_we && (ram_selector == 'd1))
  );

  glyph_rom_wrapper #(
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH),
    .DATA_WIDTH(ObiCfg.DataWidth),
    .GLYPH_WIDTH_LOG(GLYPH_WIDTH_LOG),
    .GLYPH_HEIGHT_LOG(GLYPH_HEIGHT_LOG)
  ) i_glyph_rom (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    
    .port0_ascii_i(ascii_char),
    .port0_x_i(glyph_x),
    .port0_y_i(glyph_y),
    .port0_pixel_o(one_bit_pixel_rom)
  );

  logic [7:0] color_blink_delayed;
  `FF(color_blink_delayed, color_blink, '0, clk_i, rst_ni)
  logic [7:0] color;
  color_generator #(
  ) i_color_generator (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .input_pixel_i(one_bit_pixel),
    .color_blink_i(color_blink_delayed),
    .color_palette_i(color_palette),
    .blink_disable_i(blink_disable),
    .clk_enable_i(clk_enable),
    .color_o(color)
  );

  logic [1:0][2:0] hvsync_delayed;

  `FF(hvsync_delayed[0], {output_visible_unbuffered, hsync_unbuffered, vsync_unbuffered}, '0, clk_i, rst_ni);
  `FF(hvsync_delayed[1], hvsync_delayed[0], '0, clk_i, rst_ni);

  assign hsync_o = hvsync_delayed[1][1];
  assign vsync_o = hvsync_delayed[1][0];
  assign color_o = color & {8{hvsync_delayed[1][2]}};
endmodule