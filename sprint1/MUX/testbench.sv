// Code your testbench here
// or browse Examples
module mux2x1_t;
  //sinais
  logic [3:0] ia;
  logic [3:0] ib;
  logic [3:0] s;
  logic chave;
  
  
  mux2x1 inst1(ia, ib, s,chave );
  
  initial begin
    $monitor("$time = %g,ia=%h,ib=%h,s=%h, sel=%h",$time ,ia,ib,s, chave);
    chave = 1;
    ia = 4'b0001;    ib = 4'b0010;  
    
    #1 
    chave = 0;
    ia = 4'b0001;    ib = 4'b0010; 
    
    
    #2 $finish;
    
  end
  
  
  
  initial
  begin
    $dumpfile("test.vcd");
    $dumpvars(0, inst1);
  end
  

  
endmodule