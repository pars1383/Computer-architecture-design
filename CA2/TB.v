`timescale 1ns/1ns
module TB();

    reg CLK = 1'b0, RST = 1'b1;

	RiscVSingleCycle risc_v(.CLK(CLK), .RST(RST));

    always #20 CLK = ~CLK;

	initial begin 
		#10 RST = 1'b0;
		#3300 $stop;
	end

endmodule
