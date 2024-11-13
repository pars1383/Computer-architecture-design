module counter(clk, sclr, inc, ld, pIn, co, pOut);

	input clk, sclr, inc, ld;
	input [3:0] pIn;
	output co;
	output reg [3:0] pOut;
	
	always@(posedge clk) begin
		if(sclr)
			pOut <= 10'b0;
		else if(ld)
			pOut <= pIn;
		else if(inc && pOut < 4'b1010)
			pOut <= pOut + 1;
		else
			pOut <= pOut;
	end

	assign co = &pOut;

endmodule
