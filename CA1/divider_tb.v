`timescale 1ns/1ns
module divider_tb();

	reg [9:0] a_in, b_in;
	reg clk, sclr, start;
	wire [9:0] q_out;
	wire dvz, ovf, busy, valid;

	divider CUT(a_in, b_in, clk, sclr, start, q_out, dvz, ovf, busy, valid);

	always begin #25 clk = ~clk; end
	initial
	begin
		start = 1'b0;
		sclr = 1'b0;
		clk = 1'b0;
	
		#13 sclr = 1'b1;
		#20 sclr = 1'b0;
		#13 start = 1'b1;
		#45 start = 1'b0;

		a_in = 10'd824;
		b_in = 10'd4;

		#1000 $stop;
	end
endmodule
