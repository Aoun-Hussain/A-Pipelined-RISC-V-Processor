module Hazard_Detection
(
	input id_ex_memread,
	input[4:0] id_ex_rd, if_id_rs1, if_id_rs2,
	output reg PCWrite, if_id_write, control_mux_sel
);
	
	initial 
	begin
		PCWrite = 1'b1;
		if_id_write = 1'b1;
		control_mux_sel = 1'b1;
	end
	

	always @ (*)
	begin
		if ((id_ex_memread) && ((id_ex_rd == if_id_rs1) ||  (id_ex_rd == if_id_rs2)))
		begin
			PCWrite = 1'b0;
			if_id_write = 1'b0;
			control_mux_sel = 1'b0;
		end
	    
	    else
		begin
			PCWrite = 1'b1;
			if_id_write = 1'b1;
			control_mux_sel = 1'b1;
		end
	end
endmodule

