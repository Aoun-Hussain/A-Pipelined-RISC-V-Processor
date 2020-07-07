module pipelined_processor (
	input clk,    // Clock
	input reset  // Asynchronous reset active low
);

	//Wires
	wire pc_select; //pc_mux
	wire [63:0] pc_default_out; //pc_mux
	wire [63:0] mem_branch_out; //pc_mux
	wire [63:0] pc_mux_out; //pc_mux
	wire [63:0] PC_Out;
	wire [31:0] instruction;
	wire [31:0] id_Instruction_Out;
	wire [63:0] if_id_Inst_Addr_Out;
	wire [6:0] opcode;
	wire [4:0] id_rs1;
	wire [4:0] id_rs2;
	wire [4:0] id_rd;
	wire [2:0] funct3; 
	wire [6:0] funct7; 
	wire [3:0] Funct;
	wire [63:0] readData1;
	wire [63:0] readData2;
	wire [63:0] imm_data;
	wire Branch, RegWrite, MemRead, MemToReg, MemWrite, ALUSrc;
	wire [1:0] ALUOp;
	wire [63:0] id_ex_Inst_Addr_Out;
	wire [4:0] ex_rs1;
	wire [4:0] ex_rs2;
	wire [4:0] ex_rd;
	wire [63:0] ex_readData1;
	wire [63:0] ex_readData2;
	wire [63:0] ex_imm_data;
	wire [3:0] ex_Funct;
	wire [1:0] ex_WB_out;
	wire [2:0] ex_M_out;
	wire ex_ALUSrc;
	wire [1:0] ex_ALUOp;
	wire [63:0] forward_mux_a_out;
	wire [63:0] forward_mux_b_out;
	wire [63:0] register_file_mux_out;
	wire [1:0] ForwardA;
	wire [1:0] ForwardB;
	wire [63:0] branch_adder_out;
	wire [3:0] alu_c_aluop;
	wire [63:0] alu_result;
	wire Zero, less, comp;
	wire [1:0] mem_WB_out;
	wire mem_Branch, mem_MemWrite, mem_MemRead, mem_comp;
	wire [63:0] mem_alu_result, mem_WriteData;
	wire [4:0] mem_rd;
	wire [63:0] data_memory_readData, wb_readData;
	wire wb_MemToReg, wb_RegWrite;
	wire [4:0] wb_rd;
	wire [63:0] wb_alu_result, WriteData;
	wire if_id_write, PCWrite, hm_sel;	
	wire [7:0] hm_id_ex;
	wire flush;

	//assignments
	assign Funct = {id_Instruction_Out[30], id_Instruction_Out[14:12]};
	assign pc_select = mem_Branch & mem_comp;
	assign flush = pc_select;
	
	//Modules
	Hazard_Detection hd(
		.id_ex_memread(ex_M_out[0]),
		.id_ex_rd(ex_rd), 
		.if_id_rs1(id_rs1), 
		.if_id_rs2(id_rs2),
		.PCWrite(PCWrite), 
		.if_id_write(if_id_write), 
		.control_mux_sel(hm_sel)
	);

	hazard_mux hm(
		.sel(hm_sel),
                  	.Branch(Branch), 
	  	.MemRead(MemRead),
	  	.MemToReg(MemToReg),
	  	.MemWrite(MemWrite), 
	  	.ALUSrc(ALUSrc), 
	  	.RegWrite(RegWrite),
  	  	.ALUOp(ALUOp),
  	  	.out(hm_id_ex)
	);

	mux pc_mux(
		.sel(pc_select), 
		.a(mem_branch_out), 
		.b(pc_default_out),
		.data_out(pc_mux_out)
	);

	Program_Counter pc0(
		.PC_In(pc_mux_out),
		.PC_Out(PC_Out),
		.clk(clk),
		.reset(reset),
		.PCWrite(PCWrite)
	);

	Adder pc_default_adder(
		.a(PC_Out),
		.b(64'd4),
		.out(pc_default_out)
	);

	Instruction_Memory im0(
		.Inst_Address(PC_Out),
		.instruction(instruction)
	);

	//1st register
	IF_ID if_id
	(
		.clk(clk),
		.flush(flush),
		.Instruction(instruction),
		.Inst_Addr(PC_Out),
		.Instruction_Out(id_Instruction_Out),
		.Inst_Addr_Out(if_id_Inst_Addr_Out),
		.if_id_write(if_id_write)
	);

		//Instruction Decode
	InstructionParser ip0 (
		.opcode(opcode),
		.instruction(id_Instruction_Out),
		.rs1(id_rs1),
		.rs2(id_rs2),
		.rd(id_rd),
		.funct3(funct3),
		.funct7(funct7)
	);

	registerFile rf(
		.WriteData(WriteData), 
		.rs1(id_rs1),
		.rs2(id_rs2),
		.rd(wb_rd),
		.readData1(readData1),
		.readData2(readData2),
		.RegWrite(wb_RegWrite),
		.clk(clk),
		.reset(reset)
	);

	ImmDataExtractor ide0(
		.instruction(id_Instruction_Out),
		.imm_data(imm_data)
	);

	Control_Unit cu(
		.opcode(opcode),
		.Branch(Branch),
		.ALUOp(ALUOp),
		.RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc)
	);

	//2nd register
	ID_EX id_ex
	(
		.flush(flush),
		.clk(clk),
		.Inst_Addr(if_id_Inst_Addr_Out),
		.Inst_Addr_Out(id_ex_Inst_Addr_Out),
		.rs1(id_rs1),
		.rs1_Out(ex_rs1),
		.rs2(id_rs2),
		.rs2_Out(ex_rs2),
		.rd(id_rd),
		.rd_Out(ex_rd),
		.ReadData1(readData1),
		.ReadData1_Out(ex_readData1),
		.ReadData2(readData2),
		.ReadData2_Out(ex_readData2),
		.ImmediateData(imm_data),
		.ImmediateData_Out(ex_imm_data),
		.Funct_Instruction(Funct),
		.Funct_Out(ex_Funct),
		.WB({hm_id_ex[5], hm_id_ex[6]}),
		.WB_Out(ex_WB_out),
		.M({hm_id_ex[2], hm_id_ex[3], hm_id_ex[4]}),
		.M_Out(ex_M_out),
		.EX({hm_id_ex[7], hm_id_ex[1:0]}),
		.ALUOp(ex_ALUOp),
		.ALUSrc(ex_ALUSrc)
	);
		// Execution
	forward_A_mux fam0(
		.ForwardA(ForwardA),
		.id_ex_input(ex_readData1),
		.mem_wb_input(WriteData),
		.ex_mem_input(mem_alu_result),
		.a(forward_mux_a_out)
	);
	forward_B_mux fbm0(
		.ForwardB(ForwardB),
		.id_ex_input(ex_readData2),
		.mem_wb_input(WriteData),
		.ex_mem_input(mem_alu_result),
		.b(forward_mux_b_out)
	);
	
	Adder pc_branch_adder(
		.a(id_ex_Inst_Addr_Out),
		.b(ex_imm_data << 1), // left shift imm_data by 1
		.out(branch_adder_out) 
	);

	mux register_file_mux(
		.sel(ex_ALUSrc),
		.a(ex_imm_data),
		.b(forward_mux_b_out),
		.data_out(register_file_mux_out)
	);
	ALU_Control alu_c(
		.ALUOp(ex_ALUOp),
		.Funct(ex_Funct),
		.Operation(alu_c_aluop)
	);

	alu_64 a(
		.a(forward_mux_a_out),
		.b(register_file_mux_out),
		.ALUOp(alu_c_aluop),
		.Result(alu_result),
		.CarryOut(Zero),
		.less(less)
	);

	forwarding_unit fu0(
		.id_ex_rs1(ex_rs1),
		.id_ex_rs2(ex_rs2),
		.ex_mem_RegWrite(mem_WB_out[1]),
		.ex_mem_rd(mem_rd),
		.mem_wb_RegWrite(wb_RegWrite),
		.mem_wb_rd(wb_rd),
		.ForwardA(ForwardA),
		.ForwardB(ForwardB)
	);
	
	branch_control bc0
	(
		.Funct(ex_Funct),
		.less(less),
		.CarryOut(Zero),
		.comp(comp)
	);

	//3rd register
	MEM_WB mem_wb
	(
		.clk(clk),
		.flush(flush),
		.WB(ex_WB_out),
		.WB_Out(mem_WB_out),
		.M(ex_M_out),
		.Branch(mem_Branch),
		.MemWrite(mem_MemWrite),
		.MemRead(mem_MemRead),
		.Adder_Result(branch_adder_out),
		.Adder_Result_Out(mem_branch_out),
		.comp(comp),
		.comp_Out(mem_comp),
		.ALU_Result(alu_result),
		.ALU_Result_Out(mem_alu_result),
		.Forward_B_Mux_Result(forward_mux_b_out),
		.Forward_B_Mux_Result_Out(mem_WriteData),
		.rd(ex_rd),
		.rd_out(mem_rd)
	);
		// Memory
	
	
	Data_Memory dm0(
		.MemWrite(mem_MemWrite),
		.MemRead(mem_MemRead),
		.Mem_Addr(mem_alu_result),
		.Write_Data(mem_WriteData),
		.clk(clk),
		.Read_Data(data_memory_readData)
	);
	//4th register
	EX_MEM ex_mem
	(
		.clk(clk),
		.WB(mem_WB_out),
		.Mem_to_Reg(wb_MemToReg),
		.Reg_Write(wb_RegWrite),
		.Read_Data(data_memory_readData),
		.Read_Data_out(wb_readData),
		.rd(mem_rd),
		.rd_out(wb_rd),
		.Mem_Address(mem_alu_result),
		.Mem_Address_out(wb_alu_result)
	);
	
	mux data_memory_mux(
		.sel(wb_MemToReg),
		.a(wb_readData),
		.b(wb_alu_result),
		.data_out(WriteData)
	);
endmodule
