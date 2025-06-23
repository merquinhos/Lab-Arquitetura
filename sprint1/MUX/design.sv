// Code your design here
module mux2x1 (
  input logic [3:0]a,
  input logic [3:0]b,
  output logic [3:0] out,
  input logic sel
);
  
  always @*
    if (sel)
      out = a;
  
  	else
    out =b;
  
  
endmodule