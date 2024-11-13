module PCController(input[2:0] Func3, 
					input Zero, Branch, Jump, JumpReg, 
					output reg[1:0] PCSrc);
	always@(Func3, Zero, Branch, Jump, JumpReg) begin
		PCSrc = 2'b00;
		case(Branch)
			1'b0: PCSrc = Jump    ? 2'b01 : 
						  JumpReg ? 2'b10 : 2'b00;
			1'b1: PCSrc = (Func3 == 3'h0 && Zero)  ? 2'b01 : 
						  (Func3 == 3'h1 && ~Zero) ? 2'b01 : 
						  (Func3 == 3'h4 && ~Zero) ? 2'b01 : 
						  (Func3 == 3'h5 && Zero)  ? 2'b01 : 2'b00;
			default: PCSrc = 2'bz;
		endcase
	end
endmodule
