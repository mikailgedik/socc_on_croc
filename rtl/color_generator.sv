module color_generator #(
) (
    input logic input_pixel_i,
    // [3:0] - foreground color index
    // [6:4] - background color index (inverted)
    // [7]   - blink enable
    input logic [7:0] color_blink_i,
    input logic [15:0] color_palette_i [15:0],
    input logic blink_disable_i,
    input logic is_blinking_i,
    output logic [15:0] color_o
);
    always_comb begin
        logic [15:0] fg_color;
        logic [15:0] bg_color;
        logic is_blinking;

        fg_color = color_palette_i[color_blink_i[3:0]];
        bg_color = blink_disable_i ? color_palette_i[color_blink_i[7:4]] : color_palette_i[{1'b0, color_blink_i[6:4] }];
        
        is_blinking = is_blinking_i && !blink_disable_i && color_blink_i[7];

        if(input_pixel_i == 'b1 && !is_blinking) begin
            color_o = fg_color;
        end else begin
            color_o = bg_color;
        end
    end

endmodule