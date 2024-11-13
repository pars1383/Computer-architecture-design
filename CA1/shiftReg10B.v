module shiftReg10B(clk, sclr, ld, shL, sI, sO, pIn, pOut);
	
	input clk, sclr, ld, shL, sI;
	input [9:0] pIn;
	output reg sO;
	output reg [9:0] pOut;

	always@(posedge clk) begin
		if(sclr)
			pOut <= 10'b0;
		else if(ld)
			pOut <= pIn;
		else if(shL) begin
			sO <= pOut[9];
			pOut <= {pOut[8:0], sI};
		end
	end

endmodule