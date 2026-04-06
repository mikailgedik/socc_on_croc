module socc_on_croc  #(
  parameter type obi_req_t = logic,
  parameter type obi_rsp_t = logic,
  parameter int Width = 8
) (
  input  logic     clk_i,
  input  logic     rst_ni,
  output  obi_req_t obi_req_o,
  input obi_rsp_t obi_rsp_i,

  output logic h_sync_o,
  output logic v_sync_o,
  output logic [Width-1:0] color_o
);

localparam total_pixels_h = 16'd800;
localparam active_pixels_h = 16'd640;
localparam back_porch_h = 16'd48;
localparam h_sync_width = 16'd96;

localparam total_pixels_v = 16'd525;
localparam active_pixels_v = 16'd480;
localparam back_porch_v = 16'd33;
localparam v_sync_width = 16'd2;

logic [15:0] x_pos;
logic [15:0] y_pos;

logic h_sync, v_sync, consume_one;

vga_fsm #(.Width(16)) vga_fsm (
    .clk_i(clk_i),
    .rst_ni(rst_ni),

    .max_v_i(total_pixels_v - 'h1),
    .viewable_v_i(active_pixels_v),
    .v_sync_start_i(total_pixels_v - back_porch_v - v_sync_width),
    .v_sync_end_i(total_pixels_v - back_porch_v - 'h1),

    .max_h_i(total_pixels_h - 1),
    .viewable_h_i(active_pixels_h),
    .h_sync_start_i(total_pixels_h - back_porch_h - h_sync_width),
    .h_sync_end_i(total_pixels_h - back_porch_h - 'h1),

    .consume_one_o(consume_one),
    .last_pixel_o(),
    .h_sync_o(h_sync),
    .v_sync_o(v_sync),
    .h_pos_o(x_pos),
    .v_pos_o(y_pos)
);
assign h_sync_o = h_sync;
assign v_sync_o = v_sync;

logic [Width-1:0] color;
logic no_new_data;
logic [Width-1:0] counter_q, counter_d, data;
`FF(counter_q, counter_d, 'b0, clk_i, rst_ni);

always_comb begin : color_generator
  counter_d = counter_q;
  case (counter_q)
      'h0: data = 'hFF0000;
      'h1: data = 'h00FF00;
      'h2: data = 'h0000FF;
      'd639: data = 'hFF00FF;
    default: data = 'h007f00;
  endcase
  if(!no_new_data) begin
    counter_d = counter_q + 'b1;
  end
end

fifo_v3 #(
  .FALL_THROUGH('b0),
  .DATA_WIDTH(32),
  .DEPTH(2)
) obi_fifo (
  .clk_i(clk_i),
  .rst_ni(rst_ni),
  .flush_i('b0),
  .testmode_i('b0),
  
  .full_o(no_new_data),
  .empty_o(),
  .usage_o(),

  .data_i(data),
  .push_i(!no_new_data),

  .data_o(color),
  .pop_i(consume_one)
);

assign color_o = !consume_one ? 'hFF00FF : color;

endmodule