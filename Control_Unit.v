module Control_Unit(
	input [6:0] opcode,
	output reg Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,
	output reg [1:0] ALUOp
);

always @ opcode
begin
	case (opcode[6:4])
		3'b011:
			{ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b00100010;
		3'b000:
			{ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b11110000;
		3'b010:
			{ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b10001000;
		3'b110:
			{ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b00000101;
		3'b001:
			{ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b10100010;
	endcase
end

endmodule