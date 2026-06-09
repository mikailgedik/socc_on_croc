module obi_sub(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic
) (
  // clk_vga must be a multiple of clk_obi, or clk_obi
  input logic clk_i,
  input logic rst_ni,

  output logic[ObiCfg.DataWidth-1:0] conf0_o,
  output logic[ObiCfg.DataWidth-1:0] conf1_o,
  output logic[ObiCfg.DataWidth-1:0] conf2_o,

  output logic[ObiCfg.AddrWidth-1:0] ram_addr_o,
  output logic[ObiCfg.DataWidth-1:0] ram_data_o,
  input  logic[ObiCfg.DataWidth-1:0] ram_data_i,
  output logic[ObiCfg.AddrWidth-1:0] ram_we_o,
  output logic[ObiCfg.AddrWidth-1:0] ram_selector[1:0]
);

// RAM might be something like this one
// https://github.com/IHP-GmbH/IHP-Open-PDK/blob/main/ihp-sg13g2/libs.ref/sg13g2_sram/verilog/RM_IHPSG13_2P_512x32_c2_bm_bist.v

endmodule;