module divider(input [9:0] a_in, b_in, input clk, sclr, start, output [9:0] q_out, output dvz, ovf, busy, valid);

	wire ldB, ldACC, ldQ, ldC, shLACC, shLQ, setQ0, inc, init0, bZero, lt, qNotZero, co, cNine;

	datapath dp(clk, sclr, a_in, b_in, ldB, ldACC, ldQ, ldC, shLACC, shLQ, setQ0, inc, init0, q_out, bZero, lt, qNotZero, co, cNine);

	controller cu(clk, sclr, start, bZero, co, lt, qNotZero, cNine, init0, dvz, ovf, busy, valid, shLQ, shLACC, setQ0, ldACC, ldC, ldB, ldQ, inc);

endmodule