`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module socc_on_croc  #(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic
) (
  // clk_vga must be a multiple of clk_obi, or clk_obi
  input logic clk_obi_i,
  input logic clk_vga_i,
  input logic rst_ni,

  input obi_req_t obi_req_i,
  output obi_rsp_t obi_rsp_o,
  output logic hsync_o,
  output logic vsync_o,
  output logic [7:0] color_o
);

endmodule