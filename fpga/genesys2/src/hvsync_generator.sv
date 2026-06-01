// Horizontal and vertical sync generator for VGA 640x480 @ 60 Hz
// Timing: https://projectf.io/posts/video-timings-vga-720p-1080p/
// 640x480 @ 60 Hz
// CLK: f = 25.175 MHz

module hvsync_generator (
    input logic clk_i,
    input logic rst_ni,

    input logic enable_i,

    output logic hsync_o,
    output logic vsync_o,

    output logic visible_o,

    output logic[9:0] hpos_o,
    output logic[9:0] vpos_o
);

// Horizontal timing parameters (in pixels)
parameter H_ACTIVE = 640;       // Display width
parameter H_BACK_PORCH = 48;    // Left border
parameter H_FRONT_PORCH = 16;   // Right border
parameter H_SYNC_WIDTH = 96;    // Sync pulse width

// Vertical timing parameters (in lines)
parameter V_ACTIVE = 480;       // Display height
parameter V_BACK_PORCH = 33;    // Top border
parameter V_FRONT_PORCH = 10;   // Bottom border
parameter V_SYNC_WIDTH = 2;     // Sync pulse width (in lines)

// Derived parameters
// DISPLAY -> FRONT_PORCH -> SYNC -> BACK_PORCH
parameter H_MAX = H_ACTIVE + H_FRONT_PORCH + H_SYNC_WIDTH + H_BACK_PORCH;
parameter V_MAX = V_ACTIVE + V_FRONT_PORCH + V_SYNC_WIDTH + V_BACK_PORCH;
parameter H_SYNC_START = H_ACTIVE + H_FRONT_PORCH;
parameter H_SYNC_END = H_ACTIVE + H_FRONT_PORCH + H_SYNC_WIDTH;
parameter V_SYNC_START = V_ACTIVE + V_FRONT_PORCH;
parameter V_SYNC_END = V_ACTIVE + V_FRONT_PORCH + V_SYNC_WIDTH;

logic[9:0] vcounter_q, vcounter_d;
logic[9:0] hcounter_q, hcounter_d;

always_comb begin
    hcounter_d = hcounter_q;
    vcounter_d = vcounter_q;

    if (enable_i) begin
        if ( hcounter_q == H_MAX - 1) begin
            if (vcounter_q == V_MAX - 1) begin
                vcounter_d = 10'b0;
            end else begin
                vcounter_d = vcounter_q + 1;
            end
            hcounter_d = 10'b0;
        end else begin
            hcounter_d = hcounter_q + 1;
        end
    end
end

always_ff @( posedge clk_i, negedge rst_ni ) begin
    if (rst_ni == 1'b0) begin
        hcounter_q <= 10'b0;
        vcounter_q <= 10'b0;
    end else begin
        hcounter_q <= hcounter_d;
        vcounter_q <= vcounter_d;
    end
end

assign hsync_o = ~((hcounter_q >= H_SYNC_START) && (hcounter_q < H_SYNC_END));
assign vsync_o = ~((vcounter_q >= V_SYNC_START) && (vcounter_q < V_SYNC_END));

assign visible_o = (hcounter_q < H_ACTIVE) && (vcounter_q < V_ACTIVE);
assign hpos_o = hcounter_q;
assign vpos_o = vcounter_q;
    
endmodule