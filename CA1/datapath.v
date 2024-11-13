module datapath(clk, sclr, a_in, b_in, ldB, ldACC, ldQ, ldC, shLACC, shLQ, setQ0, inc, init0,  
				q_out, bZero, lt, qNotZero, co, cNine);
	
	input clk, sclr, ldB, ldACC, ldQ, ldC, shLACC, shLQ, setQ0, inc, init0;
	input [9:0] a_in, b_in;
	
	output bZero, lt, qNotZero, co, cNine;
	output [9:0] q_out;

	wire w;
	wire [3:0] cnt;
	wire [9:0] b_out;
	wire [10:0] sub_out, ACC_out;

	assign bZero = ~|b_out;
	assign qNotZero = |q_out[9:4];
	assign cNine = cnt[3] & ~cnt[2] & cnt[1] & ~cnt[0]; 

	register regB(.clk(clk), .sclr(sclr), .ld(ldB), .pIn(b_in), .pOut(b_out));

	shiftReg10B shRegQ(.clk(clk), .sclr(sclr), .ld(ldQ), .shL(shLQ), .sI(setQ0), .sO(w), .pIn(a_in), .pOut(q_out));
	shiftReg11B shRegACC(.clk(clk), .sclr(sclr), .ld(ldACC), .shL(shLACC), .sI(w), .init0(init0), .pIn(sub_out), .pOut(ACC_out));

	comparator comp(.a(ACC_out), .b({1'b0, b_out}), .lt(lt));

	subtractor sub(.a(ACC_out), .b({1'b0, b_out}), .w(sub_out));

	counter count(.clk(clk), .sclr(sclr), .inc(inc), .ld(ldC), .pIn(4'b0001), .co(co), .pOut(cnt));

endmodule