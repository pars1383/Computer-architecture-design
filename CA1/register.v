module register(clk, sclr, ld, pIn, pOut);

	input clk, sclr, ld;
	input [9:0] pIn;
	output reg [9:0] pOut;

	always@(posedge clk) begin
		if(sclr)
			pOut <= 10'b0;
		else if(ld)
			pOut <= pIn;
		else
			pOut <= pOut;
	end

endmodule	