// Program Counter
module Program_Counter(
  			input logic clk, 
  			input logic rst,
  			input logic [31:0] PC, 
  			output logic [31:0] PC_out
);
  
  always @(posedge clk or negedge rst) 
    begin
   
      if(!rst)
        PC_out <= 0; // zera o PC
    else 
        PC_out <= PC;      
  end
endmodule


