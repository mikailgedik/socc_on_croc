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

  localparam int RAM_ADDR_WIDTH = 'd10;

  logic [RAM_ADDR_WIDTH-1:0] ram_addr;
  logic [ObiCfg.DataWidth-1:0] ram_data;
  logic ram_we;

  obi_sub #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH)
  ) i_obi_sub(
    .clk_i(clk_obi_i),
    .rst_ni(rst_ni),

    .obi_req_i(obi_req_i),
    .obi_rsp_o(obi_rsp_o),

    .conf0_o(),

    .ram_addr_o(ram_addr),
    .ram_data_o(ram_data),
    // .ram_data_i(),
    .ram_we_o(ram_we),
    .ram_selector()
  );

  always_ff @(posedge clk_obi_i) begin
    if(ram_we) begin
      $display("writing addr: %x data: %x", ram_addr, ram_data);
    end
  end


endmodule