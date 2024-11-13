module RegisterFile(input CLK, RST, WE3,
				    input[31:0] WD3,
                    input[4:0] RR1, RR2, WR3, 
                    output[31:0] RD1, RD2
					);
                    
    reg[31:0] Regs [31:0];

    always @(posedge CLK, posedge RST) begin
        if (RST)
            $readmemh("RegisterFile.txt", Regs);
        else if (WE3 & (WR3 != 5'd0)) begin
            Regs[WR3] <= WD3;
		end
    end

    assign RD1 = Regs[RR1];
    assign RD2 = Regs[RR2];

endmodule
