
module test_gen_rom #(
)(
    input  logic                 clk_i,
    input  logic                 rst_ni,
    input  logic [31:0] data_i,
    output logic [31:0] data_o
);
	logic [31:0] state_0_d, state_0_q;

    always_ff @( posedge clk_i, negedge rst_ni ) begin : assign_ffs
		state_0_q <= rst_ni ? state_0_d : 'b0;

    end

    always_comb begin
		state_0_d[0] = '1;
		state_0_d[1] = ~(data_i[2] & data_i[31]);
		state_0_d[2] = ~(data_i[27] & data_i[7]);
		state_0_d[3] = ~(data_i[15] & data_i[30]);
		state_0_d[4] = '1;
		state_0_d[5] = ~(data_i[14] ^ data_i[9]);
		state_0_d[6] = '1;
		state_0_d[7] = ~(data_i[7] & data_i[5]);
		state_0_d[8] = ~(data_i[14] & data_i[8]);
		state_0_d[9] = '1;
		state_0_d[10] = ~(data_i[14] & data_i[14]);
		state_0_d[11] = ~(data_i[14] ^ data_i[29]);
		state_0_d[12] = ~(data_i[19] | data_i[28]);
		state_0_d[13] = ~(data_i[21] & data_i[30]);
		state_0_d[14] = ~(data_i[13] & data_i[10]);
		state_0_d[15] = '1;
		state_0_d[16] = ~(data_i[17] ^ data_i[28]);
		state_0_d[17] = ~(data_i[31] | data_i[20]);
		state_0_d[18] = ~(data_i[30] ^ data_i[15]);
		state_0_d[19] = '1;
		state_0_d[20] = ~(data_i[20] | data_i[21]);
		state_0_d[21] = ~(data_i[31] | data_i[18]);
		state_0_d[22] = '1;
		state_0_d[23] = ~(data_i[23] ^ data_i[14]);
		state_0_d[24] = ~(data_i[27] & data_i[16]);
		state_0_d[25] = ~(data_i[24] & data_i[29]);
		state_0_d[26] = ~(data_i[0] ^ data_i[0]);
		state_0_d[27] = ~(data_i[17] | data_i[26]);
		state_0_d[28] = '1;
		state_0_d[29] = '1;
		state_0_d[30] = ~(data_i[25] & data_i[3]);
		state_0_d[31] = ~(data_i[31] ^ data_i[11]);
		data_o = state_0_q;
    end
endmodule
