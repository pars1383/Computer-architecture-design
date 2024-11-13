module RiscVSingleCycle(input CLK, RST);

	wire MemWrite, ALUSrc, RegWrite, Zero;
	wire[1:0] PCSrc, ResultSrc;
	wire[2:0] ALUControl, ImmSrc, Func3;
	wire[6:0] Func7, Op;
    wire[31:0] PC, PCNext, PCPlus4, PCTarget, 
    		   ImmExt, Instr, ALUResult, 
               ReadData, Result, 
               SrcA, SrcB, ReadData1, ReadData2;

	ControlUnit CU(
        .Op(Op), .Func3(Func3), .Func7(Func7), .Zero(Zero), 
		.PCSrc(PCSrc), .ResultSrc(ResultSrc), 
		.MemWrite(MemWrite), .ALUControl(ALUControl), 
       	.ALUSrc(ALUSrc), .ImmSrc(ImmSrc), 
        .RegWrite(RegWrite)
    );

    Mux4to1 PCMux(
        .Slc(PCSrc), .a(PCPlus4), .b(PCTarget),
        .c(ALUResult), .d(32'b0), .w(PCNext)
    );

	Register PCRegister(
        .CLK(CLK), .RST(RST), .In(PCNext), .Out(PC)
    );

	InstructionMemory IM(
        .ProgramCounter(PC), .Instruction(Instr)
    );

	Adder PCP4(
        .a(PC), .b(32'd4), .w(PCPlus4)
    );

	RegisterFile RF(
        .CLK(CLK), .RST(RST), .WE3(RegWrite),
        .RR1(Instr[19:15]), .RR2(Instr[24:20]), 
		.WR3(Instr[11:7]), .WD3(Result), 
		.RD1(ReadData1), .RD2(ReadData2)
    );

	Extend ImmExtend(
        .Slc(ImmSrc), .Data(Instr[31:7]), .ExtendData(ImmExt)
    );

    Mux2to1 ALUMux(
        .Slc(ALUSrc), .a(ReadData2), .b(ImmExt), .w(SrcB)
    );

	ALU ALUInstance(
        .Opc(ALUControl), .a(SrcA), .b(SrcB), 
        .Zero(Zero), .w(ALUResult)
    );

	Adder PCPImm(
        .a(PC), .b(ImmExt), .w(PCTarget)
    );

	DataMemory DM(
        .CLK(CLK), .RST(RST), .WE(MemWrite), 
		.Addr(ALUResult), .WD(ReadData2), 
        .RD(ReadData)
    );

    Mux4to1 ResultMux(
        .Slc(ResultSrc), .a(ALUResult), .b(ReadData), 
        .c(ImmExt), .d(PCPlus4), .w(Result)
    );

    assign SrcA = ReadData1;
    assign Op = Instr[6:0];
    assign Func3 = Instr[14:12];
    assign Func7 = Instr[31:25];
    
endmodule
