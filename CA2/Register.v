module Register(input CLK, RST, 
				input[31:0] In, 
				output reg[31:0] Out
				);
    
    always @(posedge CLK, posedge RST) begin
        if(RST) Out <= 31'b0;
        else Out <= In;
    end

endmodule
