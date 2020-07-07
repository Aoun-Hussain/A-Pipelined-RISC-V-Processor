module tb_final ();

	reg clk;
	reg reset;
	initial 
	begin
		clk <= 1'b0;
		reset <= 1'b0;
	end
	pipelined_processor risc_v
	(
		.clk(clk),
		.reset(reset)
	);

	always
		#5 clk <= ~clk;

endmodule