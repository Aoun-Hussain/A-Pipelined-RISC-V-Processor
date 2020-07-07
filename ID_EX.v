module ID_EX(
  input clk,
  input flush,

  // data
  input [63:0] Inst_Addr,
  output reg [63:0] Inst_Addr_Out,
  
  input [4:0] rs1,
  output reg [4:0] rs1_Out,
  
  input [4:0] rs2,
  output reg [4:0] rs2_Out,
  
  input [4:0] rd,
  output reg [4:0] rd_Out,
  
  input [63:0] ReadData1, 
  output reg [63:0] ReadData1_Out,
  
  input [63:0] ReadData2,
  output reg [63:0] ReadData2_Out,
  
  input [63:0] ImmediateData,
  output reg [63:0] ImmediateData_Out,
  
  input [3:0] Funct_Instruction, // Instruction [30, 14-12]
  output reg [3:0] Funct_Out, // Instruction [30, 14-12]

  // control
  input [1:0] WB,
  output reg [1:0] WB_Out,
  
  input [2:0] M,
  output reg [2:0] M_Out,
  
  input [2:0] EX,
  output reg [1:0] ALUOp,
  output reg ALUSrc
);

always @ (posedge clk)
begin
  if (flush == 1)
   begin
  // data
  Inst_Addr_Out <= 64'h0000000000000000;
  rs1_Out <= 5'b00000;
  rs2_Out <= 5'b00000;
  rd_Out = 5'b00000;
  ReadData1_Out <= 64'h0000000000000000;
  ReadData2_Out <= 64'h0000000000000000;
  ImmediateData_Out <= 64'h0000000000000000;
  Funct_Out <= 4'b0000;
  
  // control
  WB_Out <= 2'b00;
  M_Out <= 3'b000;
  ALUOp <= 2'b00;
  ALUSrc <= 1'b0;
 end

 else
 begin
// data
  Inst_Addr_Out = Inst_Addr;
  rs1_Out = rs1;
  rs2_Out = rs2;
  rd_Out = rd;
  ReadData1_Out = ReadData1;
  ReadData2_Out = ReadData2;
  ImmediateData_Out = ImmediateData;
  Funct_Out = Funct_Instruction;
  
  // control
  WB_Out = WB;
  M_Out = M;
  ALUOp = EX[1:0];
  ALUSrc = EX[2];
  end
end

endmodule