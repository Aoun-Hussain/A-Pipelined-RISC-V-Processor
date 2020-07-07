module mux(
  input sel,
  input [63:0] a,  
  input [63:0] b,
  output reg [63:0] data_out
);

always @ (sel or a or b)
begin
  if (sel) 
    data_out <= a;
  else
    data_out <= b;
end
endmodule