// Code your design here
module ULA (
  input logic [3:0]A,
  input logic [3:0]B,
  output logic [3:0]resul,
  output logic flag,
  input logic [1:0] sel
);
  reg [4:0] RES;
  	
  always_comb 
    begin
      RES = 5'b0;
      
      case(sel)
   	  2'b00: RES = A + B;
      2'b01: RES = A - B;
      2'b10: RES = A >> B;
      2'b11: RES = A << B;
      endcase
      resul = RES[3:0];
      flag = RES[4];
    end

endmodule