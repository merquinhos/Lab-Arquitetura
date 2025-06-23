// Code your testbench here
// or browse Examples
module muxEsomador_t;
   //sinais
  logic [3:0] A;
  logic [3:0] B;
  logic [3:0] C;
  logic S;
  logic [3:0] RES;
  
  muxEsomador inst1(A,B,C,S,RES);
  
  
   initial begin
     $monitor("$time=%g, A=%h, B=%h, C=%h, S=%h, RES=%h", $time,A,B,C,S, RES);
 	A = 4'd3; B = 4'd5; C = 4'd9; S = 1'b1;  
    #10 
    A = 4'd3; B = 4'd4; S = 1'b0;
    
    #2 $finish;
    
  end
  
  initial
  begin
    $dumpfile("test.vcd");
    $dumpvars(0, inst1);
  end
  
endmodule