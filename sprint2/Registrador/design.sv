// Code your design here

module registrador(
  			input logic clk, 
  			input logic reset,
  			input logic enable,
  			input logic [3:0] in, 
  			output reg [3:0] out
);
  reg [3:0] valor_armazenado;
  
  always @(posedge clk or negedge reset)
    begin
   
      if(!reset)
        out <= 0;
    else if (clk)
        if (enable) 
        valor_armazenado <= in;
      else
        out = valor_armazenado;
          
  end
  
   
    
endmodule
  