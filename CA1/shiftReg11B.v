module shiftReg11B(clk, sclr, ld, shL, sI, init0, pIn, pOut);
	
	input clk, sclr, ld, shL, sI, init0;
	input [10:0] pIn;
	output reg [10:0] pOut;

	always@(posedge clk) begin
		if(sclr || init0)
			pOut <= 11'b0;
		else if(ld)
			pOut <= pIn;
		else if(shL)
			pOut <= {pOut[9:0], sI};
	end

endmodule