module MEM_WB(
  input clk,
  input flush,

  // control
  input [1:0] WB,
  output reg [1:0] WB_Out,
  
  input [2:0] M,
  output reg Branch, MemWrite, MemRead,
  
  // data
  input [63:0] Adder_Result,
  output reg [63:0] Adder_Result_Out,
  
  input comp,
  output reg comp_Out,
  
  input [63:0] ALU_Result,
  output reg [63:0] ALU_Result_Out,
  
  input [63:0] Forward_B_Mux_Result,
  output reg [63:0] Forward_B_Mux_Result_Out,
  
  input [4:0] rd,
  output reg [4:0] rd_out
);

always @ (posedge clk)
begin
if (flush == 0)
begin
  // control
  WB_Out = WB;
  {Branch, MemWrite, MemRead} = M;
  
  // data
  Adder_Result_Out = Adder_Result;
  comp_Out = comp;
  ALU_Result_Out = ALU_Result;
  Forward_B_Mux_Result_Out = Forward_B_Mux_Result;
  rd_out = rd;
end

else
begin
  // control
  WB_Out <= 2'b00;
  {Branch, MemWrite, MemRead} <= 3'b000;
  
  // data
  Adder_Result_Out = 64'h0000000000000000;
  comp_Out = 1'b0;
  ALU_Result_Out = 64'h0000000000000000;
  Forward_B_Mux_Result_Out = 64'h0000000000000000;
  rd_out = 5'b00000;
end

end

endmodule
