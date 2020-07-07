module forward_A_mux (
	input [1:0] ForwardA,
	input[63:0] id_ex_input,
	input[63:0] mem_wb_input,
	input[63:0] ex_mem_input,
	output reg [63:0] a
);
	always @ (*)
	begin
		case (ForwardA)
			2'b00 : a <= id_ex_input;
			2'b01 : a <= mem_wb_input;
			2'b10 : a <= ex_mem_input;
		endcase
	end

endmodule