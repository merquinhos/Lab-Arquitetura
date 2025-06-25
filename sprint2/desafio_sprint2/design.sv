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

module contador16(
    input logic clk,             
    input logic reset,           
    input logic dir_cont,  // Sinal de direção: 0 para crescente (0-F), 1 para decrescente (F-0
  	input logic enable_contador, 
    output logic [3:0] contagem_out // Saída de 4 bits que mostra o valor da contagem
);
  
	logic [3:0] current_count;     // saída do registrador
    logic [3:0] next_count_val;    // saída do somador
    logic [3:0] mux_input_val;     // Valor que o mux seleciona para somar/subtrair (+1 ou -1)
  
  localparam [3:0] INCREMENTO = 4'b0001; // Valor para somar na contagem crescente
  localparam [3:0] DECREMENTO = 4'b1111; // Valor para somar na contagem decrescente (equivale a -1)
  
  //instancia do registrador
  
  registrador u_registrador( .clk(clk), .enable(enable_contador), .reset(reset),.in(next_count_val), .out(current_count));
  
  //instancia do mux
  
  mux2x1 u_mux2x1( .i1(INCREMENTO), .i0(DECREMENTO), .sel(dir_cont), .out(mux_input_val));
  
  //instancia do somador
  somador u_somador(.a(current_count), .b(mux_input_val), .res(next_count_val));
  
  assign contagem_out = current_count;
  
endmodule
                  
  
  
  
