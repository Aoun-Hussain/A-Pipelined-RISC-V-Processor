module Data_Memory(
	input [63:0] Mem_Addr, Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0] Read_Data
);

reg [7:0] memory [63:0];
reg [7:0] i1;
reg [7:0] i2;
reg [7:0] i3;
reg [7:0] i4;
reg [7:0] i5;
reg [7:0] i6;
reg [7:0] i7;
reg [7:0] i8;
integer i;

initial
begin
	for (i = 0; i < 64; i = i + 1)
	begin
			memory[i] = 0;
	end
	memory[0] = 3;
	memory[8] = 1;
	memory[16] = 9;
	memory[24] = 6;
	//memory[32] = 2;
	//memory[40] = 2;
	//memory[48] = 8;
	//memory[56] = 9;
end

always @ (posedge clk)
begin
	if (MemWrite)
	begin
		memory[Mem_Addr] = Write_Data[7:0];
		memory[Mem_Addr + 1] = Write_Data[15:8];
		memory[Mem_Addr + 2] = Write_Data[23:16];
		memory[Mem_Addr + 3] = Write_Data[31:24];
		memory[Mem_Addr + 4] = Write_Data[39:32];
		memory[Mem_Addr + 5] = Write_Data[47:40];
		memory[Mem_Addr + 6] = Write_Data[55:48];
		memory[Mem_Addr + 7] = Write_Data[63:56];
	end
end

always @ (*)
begin
	if (MemRead)
	begin
		i1 = memory[Mem_Addr];
		i2 = memory[Mem_Addr + 1];
		i3 = memory[Mem_Addr + 2];
		i4 = memory[Mem_Addr + 3];
		i5 = memory[Mem_Addr + 4];
		i6 = memory[Mem_Addr + 5];
		i7 = memory[Mem_Addr + 6];
		i8 = memory[Mem_Addr + 7];
		Read_Data = {i8, i7, i6, i5, i4, i3, i2, i1};
	end
end
endmodule
