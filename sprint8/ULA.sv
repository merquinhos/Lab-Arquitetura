
module ULA (
  input logic [31:0]SrcA,
  input logic [31:0]SrcB,
  output logic [31:0]ULAresult,
  output logic Z,
  input logic [2:0]ULAcontrol 
);
  reg [31:0] RES;
  	
  always @(*) 
    begin
      RES = 32'b0;
      
      case(ULAcontrol)
   	3'b000: RES = SrcA + SrcB;
      3'b001: RES = SrcA - SrcB;
      3'b010: RES = SrcA  & SrcB;
      3'b011: RES = SrcA | SrcB;
      3'b101:begin
        if (SrcA < SrcB) 
        	RES = 32'b1; 
         else 
            RES = 32'b0; 
         end 
        
      default: RES = 32'bx;
      endcase
    end
  
  assign  ULAresult = RES;
  assign Z = (ULAresult == 32'b0);
  	
endmodule