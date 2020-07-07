module forward_B_mux (
	input [1:0] ForwardB,
	input[63:0] id_ex_input,
	input[63:0] mem_wb_input,
	input[63:0] ex_mem_input,
	output reg [63:0] b
);
	
	always @ (*)
	begin
		case (ForwardB)
			2'b00 : b <= id_ex_input;
			2'b01 : b <= mem_wb_input;
			2'b10 : b <= ex_mem_input;
		endcase
	end
endmodule