module ControlUnit(input[6:0] Func7, Op, 
				   input[2:0] Func3, 
				   input Zero,
				   output[2:0] ALUControl, ImmSrc,
				   output[1:0] PCSrc, ResultSrc, 
				   output MemWrite, ALUSrc, RegWrite
				   );

	wire[1:0] ALUOp;
	wire Branch, Jump, JumpReg;
	MainController CUT1(Op, ImmSrc, ResultSrc, ALUOp, MemWrite, ALUSrc, RegWrite, Branch, Jump, JumpReg);
	ALUController CUT2(Func7, Func3, ALUOp, ALUControl);
	PCController CUT3(Func3, Zero, Branch, Jump, JumpReg, PCSrc);
endmodule
