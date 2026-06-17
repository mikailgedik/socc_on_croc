
module top(
    input logic clk,
    input logic [3:0] btn,
    input logic [3:0] sw,
    output logic [3:0] led,
    output logic [7:0] ja,
    output logic [7:0] je
);
    `include "common_cells/registers.svh"

    logic clk1, clk2, rst1_n, rst2_n, pll_locked;

    logic enable_q, enable_d;
    logic [15:0] enable_cnt_q, enable_cnt_d;

    logic h_sync, v_sync;
    logic [7:0] color;
    
    obi_tester #() i_dut (
        .clk_i     (clk1       ),
        .rst_ni    (rst1_n     ),
        
        .hsync_o(h_sync),
        .vsync_o(v_sync),
        .color_o(color),
        .obi_done()
    );

    plle2_adv i_pll (
        .clk(clk),
        .clk_out1(clk2),
        .clk_out2(clk1),
        .locked(pll_locked),
        .reset(btn[0])
    );
    
    always_ff @( posedge clk1 ) begin : reset_sync1
        rst1_n <= ~btn[0];
    end
    always_ff @( posedge clk2 ) begin : reset_sync2
        rst2_n <= ~btn[0];
    end

    `FF(enable_q, enable_d, 'b0, clk1, rst1_n);
    `FF(enable_cnt_q, enable_cnt_d, 'b0, clk1, rst1_n);
    
    assign led[0] = rst1_n;
    assign led[1] = pll_locked;
    assign led[2] = enable_q;
    assign led[3] = h_sync;

    assign je[0] = h_sync;
    assign je[1] = v_sync;

    assign je[4] = color[3]; // g
    assign je[5] = color[4];

    assign je[2] = color[0]; // b
    assign je[6] = color[1];

    assign je[3] = color[6]; // r
    assign je[7] = color[7];

    always_comb begin : enable_debounce
        enable_d = enable_q;
        enable_cnt_d = enable_cnt_q;
        if (sw[0] == 'b1) begin
            if (enable_cnt_q == '1) begin enable_d = 'b1; end
            else begin enable_cnt_d = enable_cnt_q + 'b1; end
        end else begin
            if (enable_cnt_q == 'b0) begin enable_d = 'b0; end
            else begin enable_cnt_d = enable_cnt_q - 'b1; end
        end
    end

endmodule
