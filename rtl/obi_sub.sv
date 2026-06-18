`include "common_cells/registers.svh"

module obi_sub#(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic,
  parameter int RAM_ADDR_WIDTH = 'h0,

  // Derived parameter, do not overwrite!
  parameter int DATAWIDTH_CLOG = $clog2(ObiCfg.DataWidth/8) //The lower bits must be 0 (every write/read must be aligned with ObiCfg.DataWidth/8)
) (
  // clk_vga must be a multiple of clk_obi, or clk_obi
  input logic clk_i,
  input logic rst_ni,

  input obi_req_t obi_req_i,
  output obi_rsp_t obi_rsp_o,

  output logic[ObiCfg.DataWidth-1:0] conf0_o,

  output logic[RAM_ADDR_WIDTH-1:0] ram_addr_o,
  output logic[ObiCfg.DataWidth-1:0] ram_data_o,
  output logic[(ObiCfg.DataWidth/8)-1:0] ram_be_o,
  input  logic[1:0][ObiCfg.DataWidth-1:0] ram_data_i,
  output logic ram_we_o,
  output logic ram_selector_o
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

  logic [ObiCfg.DataWidth-1:0] config_d, config_q;
  `FF(config_q, config_d, 'b0, clk_i, rst_ni);

  // OBI signals/regs
  logic [ObiCfg.IdWidth-1:0]  rid_d, rid_q;
  `FF(rid_q, rid_d, 'b0, clk_i, rst_ni);
  logic rvalid_d, rvalid_q;
  `FF(rvalid_q, rvalid_d, 'b0, clk_i, rst_ni);
  logic err_d, err_q;
  `FF(err_q, err_d, 'b0, clk_i, rst_ni);
  logic [ObiCfg.DataWidth-1:0] read_config_d, read_config_q;
  `FF(read_config_q, read_config_d, 'b0, clk_i, rst_ni);
  logic [ObiCfg.AddrWidth-1-RAM_ADDR_WIDTH-DATAWIDTH_CLOG:0] rdata_src_d, rdata_src_q;
  `FF(rdata_src_q, rdata_src_d, 'b0, clk_i, rst_ni);
  
  always_comb begin : obi_communication
    logic [ObiCfg.AddrWidth-1-RAM_ADDR_WIDTH-DATAWIDTH_CLOG:0] destination_selector;
    logic [RAM_ADDR_WIDTH+DATAWIDTH_CLOG - 1 - DATAWIDTH_CLOG:0] dest_addr;
    logic [DATAWIDTH_CLOG-1:0] lower_bits;

    destination_selector = obi_req_i.a.addr[ObiCfg.AddrWidth-1:RAM_ADDR_WIDTH+DATAWIDTH_CLOG];
    dest_addr = obi_req_i.a.addr[RAM_ADDR_WIDTH+DATAWIDTH_CLOG - 1:DATAWIDTH_CLOG];
    lower_bits = obi_req_i.a.addr[DATAWIDTH_CLOG-1:0];

    config_d = config_q;
    rdata_src_d = destination_selector;

    rid_d = obi_req_i.a.aid;
    rvalid_d = obi_req_i.req & obi_rsp_o.gnt;
    err_d = '0;
    read_config_d = 'hdeadbeef;

    ram_addr_o = '0;
    ram_data_o = '0;
    ram_be_o = '0;
    ram_we_o = '0;
    ram_selector_o = '0;

    if (lower_bits != '0) begin
      // Force all read/writes to be aligned to the bus width
      // after that, lower addr bits can be discarded
      err_d = '1;
      `ifdef VERILATOR
        $error("Lower bits should not be set!");
      `endif
    end else if (destination_selector == 'h0) begin
      case (dest_addr)
        'h0: begin
          read_config_d = config_q;
          if(obi_req_i.a.we) begin
            for(int b = 0; b < ObiCfg.DataWidth/8; b++) begin
              if (obi_req_i.a.be[b] == '1) begin
                config_d[8*b +: 8] = obi_req_i.a.wdata[8*b +: 8];
              end
            end
          end
        end
        default: begin
          err_d = '1;
          read_config_d = 'hdeadbeef;
        end
      endcase
    end else begin
      ram_addr_o = dest_addr;
      ram_we_o = obi_req_i.a.we;
      if (obi_req_i.a.we == '0) begin
        // Nothing to do - reading is done autmatically
      end else begin
        ram_data_o = obi_req_i.a.wdata;
        ram_be_o = obi_req_i.a.be;
        case (destination_selector)
          'h1: ram_selector_o = 1'd0;
          'h2: ram_selector_o = 1'd1;
          default: begin
            err_d = '1;
            ram_we_o = '0;
          end
        endcase
      end
    end
  end

  assign conf0_o = config_q;

  assign obi_rsp_o.r.rdata = rdata_src_q == 'h0 ? read_config_q : (rdata_src_q == 'h1 ? ram_data_i[0]: ram_data_i[1]);
  assign obi_rsp_o.r.rid = rid_q;
  assign obi_rsp_o.r.err = err_q;
  // assign obi_rsp_o.r.r_option = ; // TODO is this one needed? See OBI definition in croc soc
  assign obi_rsp_o.gnt = '1;
  assign obi_rsp_o.rvalid = rvalid_q;
endmodule;