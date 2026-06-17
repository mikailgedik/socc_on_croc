module color_generator #(
) (
    input logic clk_i,
    input logic rst_ni,
    input logic input_pixel_i,
    input logic [7:0] color_blink_i,
    // [3:0] - foreground color index
    // [6:4] - background color index (inverted)
    // [7]   - blink enable
    input logic [7:0] color_palette_i [15:0],
    output logic [7:0] color_o
);

    `include "common_cells/registers.svh"
    localparam BLINK_HALF = 25_175_000;
    logic [31:0] blink_counter_d, blink_counter_q;
    `FF(blink_counter_q, blink_counter_d, '0, clk_i, rst_ni);

    assign blink_counter_d = blink_counter_q >= 2 * BLINK_HALF ? 'h0 : blink_counter_q + 'h1;

    always_comb begin
        logic [7:0] fg_color;
        logic [7:0] bg_color;

        fg_color = color_palette_i[color_blink_i[3:0]];
        bg_color = color_palette_i[{1'b0, ~color_blink_i[6:4] }];
        case ({ input_pixel_i, (blink_counter_q >= BLINK_HALF) & color_blink_i[7] })
            'b01, 'b10: color_o = fg_color;
            'b00, 'b11: color_o = bg_color;
        endcase
    end

endmodule