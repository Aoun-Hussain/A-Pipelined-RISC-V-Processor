module forwarding_unit 
(
	input [4:0] id_ex_rs1,
	input [4:0] id_ex_rs2,
	input ex_mem_RegWrite, 
	input [4:0] ex_mem_rd,
	input mem_wb_RegWrite,
	input [4:0] mem_wb_rd,
	output reg [1:0] ForwardA,
	output reg [1:0] ForwardB
);
	
	initial 
	begin
		ForwardA <= 2'b00;
		ForwardB <= 2'b00;
	end
	
	always @ (*)
	begin
		ForwardA <= 2'b00;
		ForwardB <= 2'b00;
		
		if(ex_mem_RegWrite == 1'b1) begin
			if(ex_mem_rd != 5'b0) begin
				if(ex_mem_rd == id_ex_rs1) begin
					ForwardA <= 2'b10;
				end
			end
		end

		if(mem_wb_RegWrite == 1'b1) 
		begin
			if(mem_wb_rd != 5'b0) 
			begin
				if(mem_wb_rd == id_ex_rs1) 
				begin
					if(ex_mem_RegWrite != 1'b1)
						ForwardA <= 2'b01;
					if(ex_mem_rd == 5'b0)
						ForwardA <= 2'b01;
					if(ex_mem_rd != id_ex_rs1)
						ForwardA <= 2'b01;					
				end
			end
		end

		if(ex_mem_RegWrite == 1'b1) begin
			if(ex_mem_rd != 5'b0) begin
				if(ex_mem_rd == id_ex_rs2) begin
					ForwardB <= 2'b10;
				end
			end
		end

		if(mem_wb_RegWrite == 1'b1) begin
			if(mem_wb_rd != 5'b0) begin
				if(mem_wb_rd == id_ex_rs2) begin
					if(ex_mem_RegWrite != 1'b1)
						ForwardB <= 2'b01;
					if(ex_mem_rd == 5'b0)
						ForwardB <= 2'b01;
					if(ex_mem_rd != id_ex_rs2)
						ForwardB <= 2'b01;					
				end
			end
		end
	end


endmodule