module EX_MEM
(
    input clk,
    input [1:0] WB,
    output reg Mem_to_Reg, Reg_Write,
    
    input [63:0] Read_Data,
    output reg [63:0] Read_Data_out,
    
    input [4:0] rd,
    output reg [4:0] rd_out,

    input [63:0] Mem_Address,
    output reg [63:0] Mem_Address_out
    
);

    always@(posedge clk)
    begin
      Mem_to_Reg = WB[0];
      Reg_Write = WB[1];
      
      Read_Data_out = Read_Data;
      rd_out = rd;
       
      Mem_Address_out = Mem_Address;
    end

endmodule

