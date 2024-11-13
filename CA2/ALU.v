`define ADD  3'b000
`define SUB  3'b001
`define AND  3'b010
`define OR   3'b011
`define XOR  3'b100
`define SLT  3'b101
`define SLTU 3'b110

module ALU(input[2:0] Opc, 
		   input [31:0]a, b, 
		   output Zero, 
		   output reg[31:0] w);
    
    always @(Opc, a, b) begin
		w = 32'b0;
        case (Opc)
            `ADD  : w = a + b;
            `SUB  : w = a - b;
            `AND  : w = a & b;
            `OR   : w = a | b;
			`XOR  : w = a ^ b;
			`SLT  : w = $signed(a) < $signed(b) ? 32'd1 : 32'd0;
            `SLTU : w = a < b ? 32'd1 : 32'd0;
            default:  w = 32'bz;
        endcase
    end

    assign Zero = (~|w);

endmodule
