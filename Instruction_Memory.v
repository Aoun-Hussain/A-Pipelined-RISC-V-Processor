module Instruction_Memory(
	input [63:0] Inst_Address,
	output reg [31:0] instruction
);

reg [7:0] Instructions [159:0];
reg [7:0] i1;
reg [7:0] i2;
reg [7:0] i3;
reg [7:0] i4;

initial
begin
//00400593
	Instructions[0] = 8'h93;
	Instructions[1] = 8'h05;
	Instructions[2] = 8'h40;
	Instructions[3] = 8'h00;
//00000313
	Instructions[4] = 8'h13;
	Instructions[5] = 8'h03;
	Instructions[6] = 8'h00;
	Instructions[7] = 8'h00;
//00000393
	Instructions[8] = 8'h93;
	Instructions[9] = 8'h03;
	Instructions[10] = 8'h00;
	Instructions[11] = 8'h00;
//00000293
	Instructions[12] = 8'h93;
	Instructions[13] = 8'h02;
	Instructions[14] = 8'h00;
	Instructions[15] = 8'h00;
//08b30863
	Instructions[16] = 8'h63;
	Instructions[17] = 8'h08;
	Instructions[18] = 8'hb3;
	Instructions[19] = 8'h08;
//00000a93
	Instructions[20] = 8'h93;
	Instructions[21] = 8'h0a;
	Instructions[22] = 8'h00;
	Instructions[23] = 8'h00;
//006a8ab3
	Instructions[24] = 8'hb3;
	Instructions[25] = 8'h8a;
	Instructions[26] = 8'h6a;
	Instructions[27] = 8'h00;
//006a8ab3
	Instructions[28] = 8'hb3;
	Instructions[29] = 8'h8a;
	Instructions[30] = 8'h6a;
	Instructions[31] = 8'h00;
//006a8ab3
	Instructions[32] = 8'hb3;
	Instructions[33] = 8'h8a;
	Instructions[34] = 8'h6a;
	Instructions[35] = 8'h00;
//006a8ab3
	Instructions[36] = 8'hb3;
	Instructions[37] = 8'h8a;
	Instructions[38] = 8'h6a;
	Instructions[39] = 8'h00;
//006a8ab3
	Instructions[40] = 8'hb3;
	Instructions[41] = 8'h8a;
	Instructions[42] = 8'h6a;
	Instructions[43] = 8'h00;
//006a8ab3
	Instructions[44] = 8'hb3;
	Instructions[45] = 8'h8a;
	Instructions[46] = 8'h6a;
	Instructions[47] = 8'h00;
//006a8ab3
	Instructions[48] = 8'hb3;
	Instructions[49] = 8'h8a;
	Instructions[50] = 8'h6a;
	Instructions[51] = 8'h00;
//006a8ab3
	Instructions[52] = 8'hb3;
	Instructions[53] = 8'h8a;
	Instructions[54] = 8'h6a;
	Instructions[55] = 8'h00;
//00130313	
	Instructions[56] = 8'h13;
	Instructions[57] = 8'h03;
	Instructions[58] = 8'h13;
	Instructions[59] = 8'h00;
//00000393
	Instructions[60] = 8'h93;
	Instructions[61] = 8'h03;
	Instructions[62] = 8'h00;
	Instructions[63] = 8'h00;
//00030393
	Instructions[64] = 8'h93;
	Instructions[65] = 8'h03;
	Instructions[66] = 8'h03;
	Instructions[67] = 8'h00;
//fcb386e3
	Instructions[68] = 8'he3;
	Instructions[69] = 8'h86;
	Instructions[70] = 8'hb3;
	Instructions[71] = 8'hfc;
//007b0b33
	Instructions[72] = 8'h33;
	Instructions[73] = 8'h0b;
	Instructions[74] = 8'h7b;
	Instructions[75] = 8'h00;
//007b0b33
	Instructions[76] = 8'h33;
	Instructions[77] = 8'h0b;
	Instructions[78] = 8'h7b;
	Instructions[79] = 8'h00;
//007b0b33
	Instructions[80] = 8'h33;
	Instructions[81] = 8'h0b;
	Instructions[82] = 8'h7b;
	Instructions[83] = 8'h00;
//007b0b33
	Instructions[84] = 8'h33;
	Instructions[85] = 8'h0b;
	Instructions[86] = 8'h7b;
	Instructions[87] = 8'h00;
//007b0b33
	Instructions[88] = 8'h33;
	Instructions[89] = 8'h0b;
	Instructions[90] = 8'h7b;
	Instructions[91] = 8'h00;
//007b0b33
	Instructions[92] = 8'h33;
	Instructions[93] = 8'h0b;
	Instructions[94] = 8'h7b;
	Instructions[95] = 8'h00;
//007b0b33
	Instructions[96] = 8'h33;
	Instructions[97] = 8'h0b;
	Instructions[98] = 8'h7b;
	Instructions[99] = 8'h00;
//007b0b33
	Instructions[100] = 8'h33;
	Instructions[101] = 8'h0b;
	Instructions[102] = 8'h7b;
	Instructions[103] = 8'h00;
//00138393
	Instructions[104] = 8'h93;
	Instructions[105] = 8'h83;
	Instructions[106] = 8'h13;
	Instructions[107] = 8'h00;
//005a8733
	Instructions[108] = 8'h33;
	Instructions[109] = 8'h87;
	Instructions[110] = 8'h5a;
	Instructions[111] = 8'h00;
//005b07b3
	Instructions[112] = 8'hb3;
	Instructions[113] = 8'h07;
	Instructions[114] = 8'h5b;
	Instructions[115] = 8'h00;
//00000b13
	Instructions[116] = 8'h13;
	Instructions[117] = 8'h0b;
	Instructions[118] = 8'h00;
	Instructions[119] = 8'h00;
//00073803
	Instructions[120] = 8'h03;
	Instructions[121] = 8'h38;
	Instructions[122] = 8'h07;
	Instructions[123] = 8'h00;
//0007b883
	Instructions[124] = 8'h83;
	Instructions[125] = 8'hb8;
	Instructions[126] = 8'h07;
	Instructions[127] = 8'h00;
//fd1802e3
	Instructions[128] = 8'he3;
	Instructions[129] = 8'h02;
	Instructions[130] = 8'h18;
	Instructions[131] = 8'hfd;
//fd1840e3
	Instructions[132] = 8'he3;
	Instructions[133] = 8'h40;
	Instructions[134] = 8'h18;
	Instructions[135] = 8'hfd;
//01000933
	Instructions[136] = 8'h33;
	Instructions[137] = 8'h09;
	Instructions[138] = 8'h00;
	Instructions[139] = 8'h01;
//01100833
	Instructions[140] = 8'h33;
	Instructions[141] = 8'h08;
	Instructions[142] = 8'h10;
	Instructions[143] = 8'h01;
//01073023
	Instructions[144] = 8'h23;
	Instructions[145] = 8'h30;
	Instructions[146] = 8'h07;
	Instructions[147] = 8'h01;
//012008b3
	Instructions[148] = 8'hb3;
	Instructions[149] = 8'h08;
	Instructions[150] = 8'h20;
	Instructions[151] = 8'h01;
//0117b023
	Instructions[152] = 8'h23;
	Instructions[153] = 8'hb0;
	Instructions[154] = 8'h17;
	Instructions[155] = 8'h01;
//fa0004e3
	Instructions[156] = 8'he3;
	Instructions[157] = 8'h04;
	Instructions[158] = 8'h00;
	Instructions[159] = 8'hfa;

end

always @ (Inst_Address)
begin
	i1 = Instructions[Inst_Address];
	i2 = Instructions[Inst_Address + 1];
	i3 = Instructions[Inst_Address + 2];
	i4 = Instructions[Inst_Address + 3];
	instruction = {i4, i3, i2, i1};
end
endmodule