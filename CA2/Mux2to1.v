module Mux2to1(input Slc, 
			   input[31:0] a, b, 
			   output[31:0] w
			   );
      
    assign w = ~Slc ? a : b;

endmodule
