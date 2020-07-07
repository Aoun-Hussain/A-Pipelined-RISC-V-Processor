module Program_Counter
(
	input clk, reset,
	input [63:0] PC_In,
	input PCWrite,
	output reg [63:0] PC_Out
);

initial
	PC_Out = 0;
	
	
always @ (posedge clk)
begin
	if ((reset == 0) && (PCWrite == 1))
		PC_Out = PC_In;

end
endmodule
