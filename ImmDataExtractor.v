module ImmDataExtractor(
  input [31:0] instruction,
  output reg [63:0] imm_data
  );
  
always@(instruction)
	begin
	case(instruction[6]) 
		1'b0: // data transfer
			case(instruction[5]) 
				1'b0: // load
					imm_data = {{52{instruction[31]}}, instruction[31:20]};
				1'b1: // store
					imm_data = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
			endcase
		1'b1: // branch
			imm_data = {{52{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
	endcase
end
endmodule

//0100000
//0000000
//1100000
//1000000


// load 31:20 
// store 31:25, 11:7
// branch 31, 7, 30:25, 11:8