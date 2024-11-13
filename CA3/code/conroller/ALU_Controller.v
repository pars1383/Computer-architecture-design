`define ST   2'b00
`define BT   2'b01
`define RT   2'b10
`define IT   2'b11


`define ADD  3'b000
`define SUB  3'b001
`define AND  3'b010
`define OR   3'b011
`define SLTIU 3'b110
`define SLTI  3'b101
`define XOR  3'b100



module ALU_Controller(func3, func7, ALUOp, ALUControl);

    input [2:0] func3;
    input [1:0] ALUOp;
    input func7; 

    output reg [2:0] ALUControl;
    
    always @(ALUOp or func3 or func7)begin
        case (ALUOp)
            `ST   : ALUControl <= `ADD;
            `BT   : ALUControl <= `SUB;
            `RT   : ALUControl <= 
                        (func3 == 3'b000 & ~func7) ? `ADD:
                        (func3 == 3'b000 & func7) ? `SUB:
                        (func3 == 3'b111) ? `AND:
                        (func3 == 3'b110) ? `OR:
                        (func3 == 3'b011) ? `SLTIU:
                        (func3 == 3'b010) ? `SLTI : 3'bzzz;
            `IT   : ALUControl <=  
                        (func3 == 3'b000) ? `ADD:
                        (func3 == 3'b100) ? `XOR:
                        (func3 == 3'b110) ? `OR:
                        (func3 == 3'b011) ? `SLTIU:
                        (func3 == 3'b010) ? `SLTI: 3'bzzz;
            default: ALUControl <= `ADD;
        endcase
    end
endmodule