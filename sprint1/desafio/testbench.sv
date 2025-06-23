// Code your testbench here
// or browse Examples
 module ULA_t;
   //sinais
   logic [3:0]A;
   logic [3:0]B;
   logic [3:0]resul;
   logic flag;
   logic [1:0] sel;
   
   
   ULA inst1 (.A(A), .B(B),. sel(sel),.flag(flag), .resul(resul));
   
   initial
     begin
       $monitor("Tempo=%0t | A=%b B=%b resul=%b, flag = %h", $time, A, B, resul, flag);  
       sel=2'b01;
       A=4'b0111;
       B=4'b0110;
       
       #2
       sel=2'b00; 
       A=4'b1111;
       B=4'b0001;
       
       
       #2 $finish;
     end
   
   
   initial begin
     $dumpfile("test.vcd");
    $dumpvars(0, inst1);
   end
   
   
 endmodule