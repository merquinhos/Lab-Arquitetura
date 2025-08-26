module mux_2x1 (

  input logic [31:0] entrada_c, entrada_d,
  input logic sel1,
  output logic [31:0] resul1 
);
  
 always_comb  begin
    
   if(sel1==1)
      resul1=entrada_d;
    else 
      resul1=entrada_c;
      
   end
endmodule 