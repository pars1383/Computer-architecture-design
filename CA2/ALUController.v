`define ADD  3'b000
`define SUB  3'b001
`define AND  3'b010
`define OR   3'b011
`define XOR  3'b100
`define SLT  3'b101
`define SLTU 3'b110

module ALUController(input[6:0] Func7, 
					 input[2:0] Func3, 
					 input[1:0] ALUOp, 
					 output reg[2:0] ALUControl);
	always@(Func3, Func7, ALUOp) begin
		ALUControl = `ADD;
		case(ALUOp)
			2'b00: ALUControl = `ADD;
			2'b01: ALUControl = (Func7 == 7'h20) ? `SUB  : 
								(Func3 == 3'h0)  ? `ADD  :
				     		    (Func3 == 3'h7)  ? `AND  :
    						    (Func3 == 3'h6)  ? `OR   :		  
 	   							(Func3 == 3'h2)  ? `SLT  :
				   				(Func3 == 3'h3)  ? `SLTU : 3'hz;
			2'b10: ALUControl = (Func3 == 3'h0)  ? `ADD  :
				     			(Func3 == 3'h4)  ? `XOR  :
    				 			(Func3 == 3'h6)  ? `OR   :		  
 	   				 			(Func3 == 3'h2)  ? `SLT  :
				     			(Func3 == 3'h3)  ? `SLTU : 3'hz;
			2'b11: ALUControl = (Func3 == 3'h0 || Func3 == 3'h1) ? `SUB : 
								(Func3 == 3'h4 || Func3 == 3'h5) ? `SLT : 3'hz;
			default: ALUControl = 3'hz;
		endcase
	end
endmodule
