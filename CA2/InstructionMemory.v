module InstructionMemory(input[31:0] ProgramCounter, 
						 output[31:0] Instruction
						 );

    reg[31:0] InstMem[15999:0];

    initial begin
        $readmemh("AssemblyHexCode.txt", InstMem);
    end

    assign Instruction = InstMem[ProgramCounter >> 2];

endmodule
