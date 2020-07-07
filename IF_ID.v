module IF_ID(
  input clk,
  input flush,
  input if_id_write,
  input [31:0] Instruction,
  input [63:0] Inst_Addr,
  output reg [31:0] Instruction_Out,
  output reg [63:0] Inst_Addr_Out
);

always @ (posedge clk)

begin
if ((if_id_write == 1) && (flush == 0))
begin
  Instruction_Out = Instruction;
  Inst_Addr_Out = Inst_Addr;
end


if (flush == 1)
begin
    Instruction_Out <= 32'h00000000;
    Inst_Addr_Out <=  64'h0000000000000000;
end

end
endmodule
