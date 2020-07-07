module registerFile(
	input [63:0] WriteData,
	input [4:0] rs1,
	input [4:0] rs2,
	input [4:0] rd,
	output reg [63:0] readData1,
	output reg [63:0] readData2,
	input clk, reset, RegWrite
);

reg [63:0] Registers [31:0];
initial
begin
Registers[0] = 0;
Registers[1] = 0;
Registers[2] = 0;
Registers[3] = 0;
Registers[4] = 0;
Registers[5] = 0;
Registers[6] = 0;
Registers[7] = 0;
Registers[8] = 0;
Registers[9] = 0;
Registers[10] = 0;
Registers[11] = 4;
Registers[12] = 0;
Registers[13] = 0;
Registers[14] = 0;
Registers[15] = 0;
Registers[16] = 0;
Registers[17] = 0;
Registers[18] = 0;
Registers[19] = 0;
Registers[20] = 0;
Registers[21] = 0;
Registers[22] = 0;
Registers[23] = 0;
Registers[24] = 0;
Registers[25] = 0;
Registers[26] = 0;
Registers[27] = 0;
Registers[28] = 0;
Registers[29] = 0;
Registers[30] = 0;
Registers[31] = 0;

end

always @ (clk)
begin
	if (RegWrite) 
		Registers[rd] = WriteData;
end


always@(negedge clk)
begin
	if (reset) 
		begin
			readData1 = 0;
			readData2 = 0;
		end
	else
		begin
			readData1 = Registers[rs1];
			readData2 = Registers[rs2];
		end
end


endmodule
