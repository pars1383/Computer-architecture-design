module DataMemory(input CLK, RST, WE, 
				  input[31:0] Addr, WD, 
				  output[31:0] RD
				  );

	reg[31:0] DataMem [15999:0];

	assign RD = DataMem[Addr>>2];

	always @(posedge CLK,  posedge RST) begin
        if (RST) $readmemh("DataMemory.txt", DataMem);
		else if (WE) DataMem[Addr>>2] = WD;
	end

endmodule
