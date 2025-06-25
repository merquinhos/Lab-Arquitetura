// Code your design here
// Code your design here
module mux2x1 (
  input logic [3:0]i0,
  input logic [3:0]i1,
  output logic [3:0] out,
  input logic sel
);
  
  always @*
    if (sel)
      out = i1;
  
  	else
    out =i0;
  
endmodule

// Code your design here
module somador( input [3:0] a,b, output [3:0] res);
  
  assign res = a + b;
  
endmodule

// Code your design here
module registrador(
  			input logic clk, 
  			input logic reset,
  			input logic enable,
  			input logic [3:0] in, 
  			output reg [3:0] out
);
  
  always @(posedge clk or negedge reset)
    begin
   
      if(!reset)
        out <= 0;
    else if (enable) 
        out <= in;
      else
        out <= out;
          
  end
endmodule

//mux, somador e Registrador de 4bits
module muxSomadorRegistrador (
  input  logic [3:0] A,
  input  logic [3:0] B,
  input  logic [3:0] C,
  input  logic S,
  input logic CLK,
  input logic RESET,
  input logic ENABLE,
  output logic [3:0] RES
  
);
  wire logic [3:0] somador_out;
  wire logic [3:0] mux_out;

  // Instanciação do MUX
  mux2x1 u_mux (.i0(B), .i1(C), .sel(S), .out(mux_out));

  // Instanciação do somador
  somador u_somador (.a(A),.b(mux_out),.res(somador_out));
  
  //instanciação do registrador
  registrador u_registrador (.in(somador_out),.clk(CLK), .reset(RESET), .enable(ENABLE), .out(RES));
  


endmodule