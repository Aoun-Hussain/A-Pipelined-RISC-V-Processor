module branch_control(
	input [3:0] Funct,
	input less,
	input  CarryOut,
	output reg comp
);

always @ (*)
begin
	if ((Funct[2:0] == 3'b000) && ( CarryOut == 1'b1))
		comp = 1'b1;  //for beq
	else if ((Funct[2:0] == 3'b100) && ( less == 1'b1))
		comp = 1'b1; //for blt
	else
		comp = 1'b0;
end

endmodule