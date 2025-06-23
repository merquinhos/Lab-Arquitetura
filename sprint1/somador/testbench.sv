// Code your testbench here
// or browse Examples
module somador_tb;
  // sinais
  logic [3:0]ia,ib;
  logic [3:0]out;
  
  //instanciação do somador
  somador inst1(ia,ib,out);
initial
  begin
    $dumpfile("test.vcd");
    $dumpvars(0, inst1);
  end
  
  initial begin
    $monitor("time = %g, ia=%h,ib=%h,out=%h",$time ,ia,ib,out);
    ia=4'b0000;
    ib=4'b0001;
    #10
    ia=4'd2;
    ib=4'd1;
    #10 ia=4'd3;
    ib=4'd1;
    #10
    ia=4'b1010;
    ib=4'b0001;
    #10
    ia=4'b1010;
    ib=4'b0010;
    #10
    ia=4'b1010;
    ib=4'b0011;
    #2 $finish;
  end
    
  
  
endmodule