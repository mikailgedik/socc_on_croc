`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module socc_on_croc  #(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic
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

  localparam int RAM_ADDR_WIDTH = 'd10;

  logic [RAM_ADDR_WIDTH-1:0] ram_addr;
  logic [ObiCfg.DataWidth-1:0] ram_data;
  logic [1:0][ObiCfg.DataWidth-1:0] ram_data_output;
  logic [(ObiCfg.DataWidth/8)-1:0]ram_be;
  logic ram_we;
  logic ram_selector;

  obi_sub #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH)
  ) i_obi_sub(
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .obi_req_i(obi_req_i),
    .obi_rsp_o(obi_rsp_o),

    .conf0_o(),

    .ram_addr_o(ram_addr),
    .ram_data_o(ram_data),
    .ram_be_o(ram_be),
    .ram_data_i(ram_data_output),
    .ram_we_o(ram_we),
    .ram_selector_o(ram_selector)
  );

  text_ram_wrapper #(
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH),
    .DATA_WIDTH(ObiCfg.DataWidth)
  ) i_text_ram (
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .port0_char_index_i(),
    .port0_ascii_o(),
    .port0_color_blink_o(),

    .port1_addr_i(ram_addr),
    .port1_data_o(ram_data_output[0]),
    .port1_data_i(ram_data),
    .port1_be_i(ram_be),
    .port1_we_i(ram_we && (ram_selector == 'd0))
  );

  glyph_ram_wrapper #(
    .ADDRESS_WIDTH(RAM_ADDR_WIDTH),
    .DATA_WIDTH(ObiCfg.DataWidth),
    .GLYPH_DIMENSION_LOG(32'd4)
  ) i_glyph_ram (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    
    .port0_ascii_i(),
    .port0_x_i(),
    .port0_y_i(),
    .port0_pixel_o(),

    .port1_addr_i(ram_addr),
    .port1_data_o(ram_data_output[1]),
    .port1_data_i(ram_data),
    .port1_be_i(ram_be),
    .port1_we_i(ram_we && (ram_selector == 'd1))
  );
endmodule