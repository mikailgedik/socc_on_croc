
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
    logic [63:0] cnt1_d, cnt1_q, cnt2_d, cnt2_q;
    plle2_adv i_pll (
        .clk(clk),
        .clk_out1(clk1),
        .clk_out2(clk2),
        .locked(pll_locked),
        .reset(btn[0])
    );
    
    always_ff @( posedge clk1 ) begin : reset_sync1
        rst1_n <= ~btn[0];
    end
    always_ff @( posedge clk2 ) begin : reset_sync2
        rst2_n <= ~btn[0];
    end

    `FF(cnt1_q, cnt1_d, 'b0, clk1, rst1_n);
    `FF(cnt2_q, cnt2_d, 'b0, clk2, rst2_n);
    assign cnt1_d = cnt1_q + 'b1;
    assign cnt2_d = cnt2_q + 'b1;

    assign led[0] = rst1_n;
    assign led[1] = pll_locked;
    assign led[2] = cnt2_q[25];
    assign led[3] = cnt1_q[25];

    assign je[0] = btn[0];
    assign je[1] = btn[1];
    assign je[2] = btn[2];
    assign je[3] = btn[3];
    assign je[4] = sw[0];
    assign je[5] = sw[1];
    assign je[6] = sw[2];
    assign je[7] = sw[3];
    
endmodule
