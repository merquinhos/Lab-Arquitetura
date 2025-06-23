// Code your design here
module mux2x1 (
  input logic [3:0]i0,
  input logic [3:0]i1,
  output logic [3:0] out,
  input logic sel
);
  
  always @*
    if (sel)
      out = i0;
  
  	else
    out =i1;
  
endmodule

// Code your design here
module somador( input [3:0] a,b, output [3:0] res);
  
  assign res = a + b;
  
endmodule

//mux e somador
module muxEsomador (
  input  logic [3:0] A,
  input  logic [3:0] B,
  input  logic [3:0] C,
  input  logic S,
  output logic [3:0] RES
);
  wire logic [3:0] mux_out;

  // Instanciação do MUX
  mux2x1 u_mux (.i0(B), .i1(C), .sel(S), .out(mux_out));

  // Instanciação do somador
  somador u_somador (.a(A),.b(mux_out),.res(RES));
endmodule