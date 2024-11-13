`define RT  	7'b0110011
`define IT 		7'b0010011
`define IT_LW   7'b0000011
`define IT_JALR 7'b1100111
`define ST  	7'b0100011
`define JT 	 	7'b1101111
`define BT 	 	7'b1100011
`define UT  	7'b0110111

module MainController(input[6:0] Op, 
					  output reg[2:0] ImmSrc,  
					  output reg[1:0] ResultSrc, ALUOp, 
					  output reg MemWrite, ALUSrc, RegWrite, Branch, Jump, JumpReg);
	
	always@(Op) begin
		{ImmSrc, ALUOp, ResultSrc, MemWrite, ALUSrc, RegWrite, Branch, Jump, JumpReg} = 13'b0;
		case(Op)
			`RT:      begin ALUOp = 2'b01; ResultSrc = 2'b00; {ALUSrc, RegWrite} = 2'b01; end
			`IT:      begin ImmSrc = 3'b000; ALUOp = 2'b10; ResultSrc = 2'b00; {ALUSrc, RegWrite} = 2'b11; end
			`IT_LW:   begin ImmSrc = 3'b000; ALUOp = 2'b00; ResultSrc = 2'b01; {ALUSrc, RegWrite} = 2'b11; end
			`IT_JALR: begin ImmSrc = 3'b000; ALUOp = 2'b00; ResultSrc = 2'b11; {ALUSrc, RegWrite, JumpReg} = 3'b111; end
			`ST:      begin ImmSrc = 3'b001; ALUOp = 2'b00; {MemWrite, ALUSrc} = 2'b11; end
			`JT:      begin ImmSrc = 3'b010; ResultSrc = 2'b11; {RegWrite, Jump} = 2'b11; end
			`BT:      begin ImmSrc = 3'b011; ALUOp = 2'b11; {ALUSrc, Branch} = 2'b01; end
			`UT:      begin ImmSrc = 3'b100; ResultSrc = 2'b10; RegWrite = 1'b1; end
		endcase
	end
endmodule
