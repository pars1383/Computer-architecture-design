`define IT 3'b000
`define ST 3'b001
`define JT 3'b010
`define BT 3'b011
`define UT 3'b100

module Extend(input[2:0] Slc, 
			  input[24:0] Data, 
			  output reg[31:0] ExtendData
			  );

    always @(Slc, Data) begin
		ExtendData = 32'b0;
        case(Slc)
            `IT: ExtendData = {{20{Data[24]}}, Data[24:13]};
            `ST: ExtendData = {{20{Data[24]}}, Data[24:18], Data[4:0]};
            `JT: ExtendData = {{12{Data[24]}}, Data[12:5], Data[13], Data[23:14], 1'b0};
            `BT: ExtendData = {{20{Data[24]}}, Data[0], Data[23:18], Data[4:1], 1'b0};
            `UT: ExtendData = {Data[24:5], {12{1'b0}}};
            default: ExtendData = 32'bz;
        endcase
    end

endmodule
