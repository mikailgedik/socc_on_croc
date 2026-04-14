`include "common_cells/registers.svh"
`include "obi/typedef.svh"

module socc_on_croc  #(
  parameter obi_pkg::obi_cfg_t ObiCfg = obi_pkg::ObiDefaultConfig,
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic,
  parameter int ColorWidthBytes = 1
) (
  input  logic     clk_i,
  input  logic     rst_ni,
  input logic enable_i,
  input logic hsync_pol_i,
  input logic vsync_pol_i,

  output obi_req_t obi_req_o,
  input obi_rsp_t obi_rsp_i,

  output logic h_sync_o,
  output logic v_sync_o,
  output logic [8*ColorWidthBytes-1:0] color_o
);

localparam FSM_REG_WIDTH = 16;
localparam BUFFER_DEPTH_BASE = 3;
localparam MAX_OUTSTANDING_REQS_BASE = 3;

localparam total_pixels_h = 16'd800;
localparam active_pixels_h = 16'd640;
localparam back_porch_h = 16'd48;
localparam h_sync_width = 16'd96;

localparam total_pixels_v = 16'd525;
localparam active_pixels_v = 16'd480;
localparam back_porch_v = 16'd33;
localparam v_sync_width = 16'd2;

// We should be flushig once we read beyond the last pixel. See TODO
typedef enum {FLUSHING, WORKING} state_t;


logic h_sync, v_sync, consume_one, last_pixel;
state_t state_q, state_d;
logic [MAX_OUTSTANDING_REQS_BASE-1:0] outstanding_reqs_q, outstanding_reqs_d;
logic [31:0] addr_req_q, addr_req_d;
logic requesting_q, requesting_d;
logic request_accepted;
`FF(state_q, state_d, FLUSHING, clk_i, rst_ni);
`FF(outstanding_reqs_q, outstanding_reqs_d, 'b0, clk_i, rst_ni);
`FF(addr_req_q, addr_req_d, 'b0, clk_i, rst_ni);
`FF(requesting_q, requesting_d, 'b0, clk_i, rst_ni);

logic [ObiCfg.DataWidth-1:0] fifo_o;
logic fifo_empty;
logic fifo_full;
logic [BUFFER_DEPTH_BASE:0] fifo_usage;


logic [ObiCfg.DataWidth-1:0] barrel_pixel_q, barrel_pixel_d;
logic [$clog2(ObiCfg.DataWidth/8)-1:0] barrel_shift_q, barrel_shift_d;
logic fifo_pop_d, fifo_pop_q;
logic loaded_q, loaded_d;
logic sync_loss_d, sync_loss_q;

`FF(barrel_pixel_q,barrel_pixel_d,'b0,clk_i,rst_ni);
`FF(barrel_shift_q,barrel_shift_d,'b0,clk_i,rst_ni);
`FF(fifo_pop_q,fifo_pop_d,'b0,clk_i,rst_ni);
`FF(loaded_q,loaded_d,'b0,clk_i,rst_ni);
`FF(sync_loss_q,sync_loss_d,'b0,clk_i,rst_ni);


vga_fsm #(
    .Width(FSM_REG_WIDTH)
  ) vga_fsm (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .enable_i(enable_i),

    .max_v_i(total_pixels_v - 'h1),
    .viewable_v_i(active_pixels_v),
    .v_sync_start_i(total_pixels_v - back_porch_v - v_sync_width),
    .v_sync_end_i(total_pixels_v - back_porch_v - 'h1),

    .max_h_i(total_pixels_h - 1),
    .viewable_h_i(active_pixels_h),
    .h_sync_start_i(total_pixels_h - back_porch_h - h_sync_width),
    .h_sync_end_i(total_pixels_h - back_porch_h - 'h1),

    .hsync_pol_i(hsync_pol_i),
    .vsync_pol_i(vsync_pol_i),

    .consume_one_o(consume_one),
    .last_pixel_o(last_pixel),
    .h_sync_o(h_sync),
    .v_sync_o(v_sync)
);
assign h_sync_o = h_sync;
assign v_sync_o = v_sync;

assign obi_req_o.a.addr = addr_req_q;
assign obi_req_o.a.we = 'b0;
assign obi_req_o.a.be = ~'b0;
assign obi_req_o.a.wdata = 'b0;
assign obi_req_o.a.aid = 'b0;
assign obi_req_o.a.a_optional = 'b0;
assign obi_req_o.req = requesting_q;

assign state_d = enable_i ? WORKING : FLUSHING;
assign request_accepted = obi_req_o.req && obi_rsp_i.gnt;

always_comb begin : obi_channels
  logic is_enough_space_left;
  logic is_enough_outstanding_request_left;
  logic want_to_make_request;
  outstanding_reqs_d = outstanding_reqs_q;
  addr_req_d = addr_req_q;
  requesting_d = requesting_q;

  // TODO is this a bug in fifo_v3 when DEPTH is a power of 2? since maybe buggy -> use fifo_full too
  // Check whether we want to make a request during the *next* cycle!
  // This does not consider that the FIFO might be popped this cycle, as we want to enable a CDC later on
  // Upper bound next clock cycle is:
  // - amount of items this cycle
  // - how many items are outstanding this cycle
  // - whether we're accepting a request this cycle
  is_enough_space_left = (fifo_usage) + (outstanding_reqs_q) + (request_accepted) != (1 << BUFFER_DEPTH_BASE) && !fifo_full; // TODO check signal widths...
  is_enough_outstanding_request_left = outstanding_reqs_q - obi_rsp_i.rvalid != ((1 << MAX_OUTSTANDING_REQS_BASE) - 1);
  want_to_make_request = is_enough_outstanding_request_left && is_enough_space_left;
  
  want_to_make_request &= enable_i;

  // subordinate may raise GNT without us requesting
  if (request_accepted) begin
    outstanding_reqs_d++;
    addr_req_d += 'h4;
  end else begin
    // Do never retract ongoing request if not granted, as this violates standart. should only happen if enable_i gets deasserted
    // TODO assert above condition
    want_to_make_request |= requesting_q;    
  end

  if(obi_rsp_i.rvalid) begin
    // TODO assert that this only happens when outstanding_reqs_d is > 0
    outstanding_reqs_d--;
  end

  requesting_d = want_to_make_request;
end

fifo_v3 #(
  .FALL_THROUGH('b0),
  .DATA_WIDTH(ObiCfg.DataWidth),
  .DEPTH(1 << BUFFER_DEPTH_BASE)
) obi_fifo (
  .clk_i(clk_i),
  .rst_ni(rst_ni),
  .flush_i(state_q == FLUSHING),
  .testmode_i('b0),
  
  .full_o(fifo_full),
  .empty_o(fifo_empty),
  .usage_o(fifo_usage),

  .data_i(obi_rsp_i.r.rdata),
  .push_i(obi_rsp_i.rvalid),

  .data_o(fifo_o),
  .pop_i(fifo_pop_d)
);

always_comb begin : barrel_roll
  logic need_to_roll;
  logic data_spans_two_words;
  barrel_pixel_d = barrel_pixel_q;
  barrel_shift_d = barrel_shift_q;
  fifo_pop_d = 'b0;
  loaded_d = loaded_q;
  sync_loss_d = sync_loss_q;

  // data_spans_two_words when: barrel_shift_q + ColorWidthBytes > (ObiCfg.DataWidth/8)
  // need_to_rool when: barrel_shift_q + ColorWidthBytes >= (ObiCfg.DataWidth/8)
  data_spans_two_words = barrel_shift_q > (ObiCfg.DataWidth/8) - ColorWidthBytes;
  need_to_roll = barrel_shift_q >= (ObiCfg.DataWidth/8) - ColorWidthBytes;

  case ({loaded_q, consume_one})
    'b00: begin
      if(!fifo_empty) begin
        loaded_d = 'b1;
        barrel_pixel_d = fifo_o;
        fifo_pop_d = 'b1;
        barrel_shift_d = 'b0;
      end
    end
    'b10: begin
      // Nothing to do - wait
    end
    'b01: begin
      sync_loss_d = 'b1;
      // On sync loss: Stop pixel fetching etc etc
      $display("TODO: %t, %d", $time, {loaded_q, consume_one});
    end
    'b11: begin
      if(data_spans_two_words && fifo_empty) begin
        sync_loss_d = 'b1;
      end
      if(need_to_roll) begin
        barrel_shift_d = ($clog2(ObiCfg.DataWidth/8))'(barrel_shift_q - ((ObiCfg.DataWidth/8) - ColorWidthBytes));
        if(!fifo_empty) begin
          loaded_d = 'b1;
          barrel_pixel_d = fifo_o;
          fifo_pop_d = 'b1;
        end else begin
          loaded_d = 'b0;
        end
      end else begin
        barrel_shift_d += ($clog2(ObiCfg.DataWidth/8))'(ColorWidthBytes);
      end
    end
    default: $error("This should not happen...");
  endcase
  // TODO check sync loss here and adjust accordingly
  // If not enabled, clear
  loaded_d &= enable_i;
end

// Safeguard for debugging: generally hide pixel content if not showing anything
logic [2*ObiCfg.DataWidth-1:0] tmp, shifted;

assign tmp = {fifo_o, barrel_pixel_q};
assign shifted = tmp >> (barrel_shift_q*(64'h8));
assign color_o = !consume_one ? 'hFF00FF : (ColorWidthBytes*8)'((2*ObiCfg.DataWidth)'({fifo_o, barrel_pixel_q}) >> (barrel_shift_q*(64'h8)));

endmodule