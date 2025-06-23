// Code your testbench here
// or browse Examples
module xor_t;
  
  //sinais 
  logic ia, ib;
  logic s;
  
  //instanciação da porta xor
  xor2x1 inst1(ia,ib,s);
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, inst1);
    end
  
  initial begin
    $monitor( "time = %g, ia = %h, ib= %h, s= %h", $time,ia,ib,s);
    //geração de sinais de entrada
    ia = 1'b1;
    ib = 1'b0;
    #10
    ib = 1'b1;
    #10
    ia=1'b0;
    #10
    ib=1'b0;
 	end
endmodule