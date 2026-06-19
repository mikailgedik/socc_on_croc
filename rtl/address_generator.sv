module address_generator #(
    parameter int COUNTER_WIDTH = 10,
    parameter int GLYPH_WIDTH_BITS = 16,
    parameter int GLYPH_HEIGHT_BITS = 16,
    parameter int PIXELS_PER_ROW = 640,
    parameter int RAM_ADDR_WIDTH = 10
) (
    input logic [COUNTER_WIDTH-1:0] screen_x,
    input logic [COUNTER_WIDTH-1:0] screen_y,
    // Since every character is two bytes, the index has a bit more
    output logic [RAM_ADDR_WIDTH:0] character_index_o
);

always_comb begin
    logic[RAM_ADDR_WIDTH:0] x_idx;
    logic[RAM_ADDR_WIDTH:0] y_idx;
    
    x_idx = (RAM_ADDR_WIDTH+1)'(screen_x / GLYPH_WIDTH_BITS);
    y_idx = (RAM_ADDR_WIDTH+1)'(screen_y / GLYPH_HEIGHT_BITS);

    character_index_o = x_idx + y_idx * (RAM_ADDR_WIDTH+1)'(PIXELS_PER_ROW / GLYPH_WIDTH_BITS);
end

endmodule