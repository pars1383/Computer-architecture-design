module subtractor(a, b, w);

	input [10:0] a, b;
	output [10:0] w;

	assign w = a - b;

endmodule
