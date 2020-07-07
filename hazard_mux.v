module hazard_mux(
  input sel,
  input  reg Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,
  input  reg [1:0] ALUOp,
  output reg [7:0] out
);

always @ (*)
begin
  if (sel) 
    out <= {ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp};
  else
    out <= 8'b00000000;
end
endmodule
