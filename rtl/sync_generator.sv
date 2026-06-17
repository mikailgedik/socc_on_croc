`include "common_cells/registers.svh"

module sync_generator #(
    parameter int COUNTER_WIDTH = 10,

    // Horizontal timing parameters (in pixels)
    parameter int H_ACTIVE = 640,       // Display width
    parameter int H_BACK_PORCH = 48,    // Left border
    parameter int H_FRONT_PORCH = 16,   // Right border
    parameter int H_SYNC_WIDTH = 96,    // Sync pulse width

    // Vertical timing parameters (in lines)
    parameter int V_ACTIVE = 480,       // Display height
    parameter int V_BACK_PORCH = 33,    // Top border
    parameter int V_FRONT_PORCH = 10,   // Bottom border
    parameter int V_SYNC_WIDTH = 2      // Sync pulse width (in lines)
) (
    input logic clk_i,
    input logic rst_ni,
    input logic clk_enable_i,

    output logic hsync_o,
    output logic vsync_o,

    output logic visible_o,

    output logic[COUNTER_WIDTH-1:0] hpos_o,
    output logic[COUNTER_WIDTH-1:0] vpos_o
);
    `include "common_cells/registers.svh"

    // Derived parameters
    // DISPLAY -> FRONT_PORCH -> SYNC -> BACK_PORCH
    localparam H_MAX = H_ACTIVE + H_FRONT_PORCH + H_SYNC_WIDTH + H_BACK_PORCH;
    localparam V_MAX = V_ACTIVE + V_FRONT_PORCH + V_SYNC_WIDTH + V_BACK_PORCH;
    localparam H_SYNC_START = H_ACTIVE + H_FRONT_PORCH;
    localparam H_SYNC_END = H_ACTIVE + H_FRONT_PORCH + H_SYNC_WIDTH;
    localparam V_SYNC_START = V_ACTIVE + V_FRONT_PORCH;
    localparam V_SYNC_END = V_ACTIVE + V_FRONT_PORCH + V_SYNC_WIDTH;

    logic[COUNTER_WIDTH-1:0] vcounter_q, vcounter_d;
    logic[COUNTER_WIDTH-1:0] hcounter_q, hcounter_d;
    `FF(vcounter_q, vcounter_d, '0, clk_i, rst_ni)
    `FF(hcounter_q, hcounter_d, '0, clk_i, rst_ni)

    always_comb begin
        hcounter_d = hcounter_q;
        vcounter_d = vcounter_q;

        if (clk_enable_i) begin
            if ( 32'(hcounter_q) == H_MAX - 1) begin
                if (32'(vcounter_q) == V_MAX - 1) begin
                    vcounter_d = 'b0;
                end else begin
                    vcounter_d = vcounter_q + 1;
                end
                hcounter_d = 'b0;
            end else begin
                hcounter_d = hcounter_q + 1;
            end
        end
    end

    assign hsync_o = ~((32'(hcounter_q) >= H_SYNC_START) && (32'(hcounter_q) < H_SYNC_END));
    assign vsync_o = ~((32'(vcounter_q) >= V_SYNC_START) && (32'(vcounter_q) < V_SYNC_END));

    assign visible_o = (32'(hcounter_q) < H_ACTIVE) && (32'(vcounter_q) < V_ACTIVE);
    assign hpos_o = hcounter_q;
    assign vpos_o = vcounter_q;

endmodule