`timescale 1ns / 1ps

`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module obi_tester #(
) (
    input logic clk_i,
    input logic rst_ni,

    output logic vsync_o,
    output logic hsync_o,
    output logic[7:0] color_o,
    output logic obi_done
);
  localparam total_pixels_h = 16'd800;
  localparam active_pixels_h = 16'd640;
  localparam back_porch_h = 16'd48;
  localparam h_sync_width = 16'd96;

  localparam total_pixels_v = 16'd525;
  localparam active_pixels_v = 16'd480;
  localparam back_porch_v = 16'd33;
  localparam v_sync_width = 16'd2;

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

  obi_req_t obi_req;
  obi_rsp_t obi_rsp;

  socc_on_croc #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t),
    .OBI_ADDRESS_OFFSET('0)
  ) socc (
    .clk_i (clk_i),
    .rst_ni    (rst_ni),

    .obi_req_i(obi_req),
    .obi_rsp_o(obi_rsp),
    .hsync_o(hsync_o),
    .vsync_o(vsync_o),
    .color_o(color_o)
  );

  obi_manager #(
    .ObiCfg(ObiCfg),
    .obi_req_t(obi_req_t),
    .obi_rsp_t(obi_rsp_t)
  ) manager (
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .obi_req_o(obi_req),
    .obi_rsp_i(obi_rsp),
    .done(obi_done)
  );

endmodule
