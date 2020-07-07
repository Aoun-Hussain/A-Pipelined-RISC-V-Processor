module Adder(
	input [63:0] a,b, 
	output wire [63:0] out
);
	assign out = a + b;
endmodule