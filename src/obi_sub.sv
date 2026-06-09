`include "common_cells/registers.svh"

module obi_sub(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic,
  parameter int RAM_ADDR_WIDTH = 'h0,
) (
  // clk_vga must be a multiple of clk_obi, or clk_obi
  input logic clk_i,
  input logic rst_ni,

  input obi_req_t obi_req_i,
  output obi_rsp_t obi_rsp_o,

  output logic[ObiCfg.DataWidth-1:0] conf0_o,
  output logic[ObiCfg.DataWidth-1:0] conf1_o,
  output logic[ObiCfg.DataWidth-1:0] conf2_o,
  output logic[ObiCfg.DataWidth-1:0] conf3_o,

  output logic[RAM_ADDR_WIDTH-1:0] ram_addr_o,
  output logic[ObiCfg.DataWidth-1:0] ram_data_o,
  input  logic[1:0][ObiCfg.DataWidth-1:0] ram_data_i,
  output logic ram_we_o,
  output logic ram_selector
);

  // /// OBI Xbar -> Subordinate address channel
  // typedef struct packed {
  //   logic [  SbrObiCfg.AddrWidth-1:0] addr;
  //   logic                             we;
  //   logic [SbrObiCfg.DataWidth/8-1:0] be;
  //   logic [  SbrObiCfg.DataWidth-1:0] wdata;
  //   logic [    SbrObiCfg.IdWidth-1:0] aid;
  //   logic                             a_optional; // dummy signal; not used
  // } sbr_obi_a_chan_t;
  // /// OBI Xbar -> Subordinate request
  // typedef struct packed {
  //   sbr_obi_a_chan_t a;
  //   logic            req;
  // } sbr_obi_req_t;

  // /// OBI Xbar <- Subordinate response channel
  // typedef struct packed {
  //   logic [SbrObiCfg.DataWidth-1:0] rdata;
  //   logic [  SbrObiCfg.IdWidth-1:0] rid;
  //   logic                           err;
  //   logic                           r_optional; // dummy signal; not used
  // } sbr_obi_r_chan_t;
  // /// OBI Xbar <- Subordinate response
  // typedef struct packed {
  //   sbr_obi_r_chan_t r;
  //   logic            gnt;
  //   logic            rvalid;
  // } sbr_obi_rsp_t;

  logic [1:0][ObiCfg.DataWidth-1:0] config_d, config_q;
  `FF(config_q, config_d, 'b0, clk_i, rst_ni);

  // OBI signals/regs
  logic [ObiCfg.IdWidth-1:0]  rid_d, rid_q;
  `FF(rid_q, rid_d, 'b0, clk_i, rst_ni);
  logic rvalid_d, rvalid_q;
  `FF(rvalid_q, rvalid_d, 'b0, clk_i, rst_ni);
  logic err_d, err_q;
  `FF(err_q, err_d, 'b0, clk_i, rst_ni);
  logic [ObiCfg.DataWidth-1:0] rdata;


  always_comb begin : obi_communication
    config_d = config_q;

    rid_d = obi_req_i.a.aid;
    rvalid_d = obi_req_i.req & obi_rsp_o.gnt;
    err_d = '0;
    rdata = '0;

    ram_addr_o = '0;
    ram_data_o = '0;
    ram_we_o = '0;
    ram_selector[1:0] = '0;

    logic [ObiCfg.AddrWidth-1:RAM_ADDR_WIDTH] destination_selector = obi_req_i.req.addr[ObiCfg.AddrWidth-1:RAM_ADDR_WIDTH];
    logic [RAM_ADDR_WIDTH-1:0] dest_addr = obi_req_i.req.addr[RAM_ADDR_WIDTH-1:0];

    if (destination_selector == 'h0) begin
      case (dest_addr) begin
        'h0,'h1,'h2,'h3: begin
          rdata = config_q[dest_addr[1:0]];
          if(obi_req_i.req.we) begin
            generate
              for(int b = 0; b < ObiCfg.DataWidth/8; i++) begin
                if (obi_req_i.req.be[b] == '1) begin
                  config_d[dest_addr[1:0]][8*b +: 8] = obi_req_i.req.wdata[8*b +: 8];
                end
              end
            endgenerate
          end
        end
        default: err_d = '1;
      end
    end else begin
      ram_addr_o = dest_addr;
      ram_we_o = obi_req_i.req.we;
      if (obi_req_i.req.we == '0) begin
        err_d = '1; // TODO no reading yet - maybe later?
        rdata = 'hdeadbeef;
      end else begin
        ram_data_o = obi_req_i.req.wdata;
        case (destination_selector) begin
          'h1: ram_selector = '0;
          'h2: ram_selector = '1;
          default: err_d = '1;
        end
      end
    end
  end

  assign conf0_o = config_q[0];
  assign conf1_o = config_q[1];
  assign conf2_o = config_q[2];
  assign conf3_o = config_q[3];

  assign obi_rsp_o.r.rdata = rdata;
  assign obi_rsp_o.r.rid = rid_q;
  assign obi_rsp_o.r.err = err_q;
  // assign obi_rsp_o.r.r_option = ; // TODO is this one needed? See OBI definition in croc soc
  assign obi_rsp_o.gnt = '1;
  assign obi_rsp_o.rvalid = rvalid_q;
endmodule;