module vga_fsm #(
    // TODO optimize Width. 2^16 is too much, at 1920x1080 we have max 2200h 1125v pixels. 2^12 and 2^11 suffice
    parameter int Width = 16
) (
    input logic clk_i,
    input logic rst_ni,

    // One frame = (max_v_i + 1) * (max_h_i + 1) pixels!
    // Not the same with viewable_X_i; here, only specified value is shown (no +1)
    input logic [Width-1:0] max_v_i,
    input logic [Width-1:0] max_h_i,
    input logic [Width-1:0] viewable_h_i,
    input logic [Width-1:0] viewable_v_i,

    input logic [Width-1:0] h_sync_start_i,
    input logic [Width-1:0] h_sync_end_i,
    input logic [Width-1:0] v_sync_start_i,
    input logic [Width-1:0] v_sync_end_i,

    output logic consume_one_o,
    output logic last_pixel_o,
    output logic h_sync_o,
    output logic v_sync_o,
    output logic [Width-1:0] h_pos_o,
    output logic [Width-1:0] v_pos_o
);

/*
    For timings see: https://projectf.io/posts/video-timings-vga-720p-1080p
    640x480p60:
    max_v_i(total_pixels - 1)
    viewable_v_i(active_pixels)
    h_sync_start_i(total_pixels - h_back_porch - h_sync_width)
    h_sync_end_i(total_pixels - h_back_porch - 1)

*/

logic [Width-1:0] counter_h_q, counter_h_d, counter_v_q, counter_v_d;

// TODO correctly "turn off" the machine with an enable_i
`FF(counter_h_q, counter_h_d, ~'b0, clk_i, rst_ni);
`FF(counter_v_q, counter_v_d, ~'b0, clk_i, rst_ni);

always_comb begin : counters
    counter_h_d = counter_h_q - 'b1;
    counter_v_d = counter_v_q;

    if (counter_h_q == 'h0) begin
        counter_v_d = counter_v_q - 'b1;
        counter_h_d = max_h_i;
        
        if (counter_v_q == 'h0) begin
            counter_v_d = max_v_i;
        end
    end
end

assign last_pixel_o = counter_h_q == 0 && counter_v_q == 0;
assign consume_one_o = counter_h_q < viewable_h_i && counter_v_q < viewable_v_i;
assign h_sync_o = !((counter_h_q >= h_sync_start_i) && (counter_h_q <= h_sync_end_i));
assign v_sync_o = !((counter_v_q >= v_sync_start_i) && (counter_v_q <= v_sync_end_i));
assign h_pos_o = counter_h_q;
assign v_pos_o = counter_v_q;

endmodule