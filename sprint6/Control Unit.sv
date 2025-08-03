
module Control_Unit(
	input [6:0] OP,
	input logic [2:0] Funct3,
	input logic [6:0] Funct7,
	
	output logic RegWrite,
	output logic ULASrc,
	output logic [2:0] ULAControl
); 

always_comb begin
	RegWrite   = 1'b0;
	ULASrc     = 1'b0;
	ULAControl = 3'b0;
	
	case(OP)
	7'b0110011: begin // TIPO R
	
	ULASrc = 1'b0;
	RegWrite = 1'b1;
	//dentro do op criamos outras case
	
	case({Funct3, Funct7})
	{3'b000, 7'b0000000}: ULAControl = 3'b000; // ADD
   {3'b000, 7'b0100000}: ULAControl = 3'b001; // SUB
   {3'b111, 7'b0000000}: ULAControl = 3'b010; // AND
   {3'b110, 7'b0000000}: ULAControl = 3'b011; // OR
   {3'b010, 7'b0000000}: ULAControl = 3'b101; // SLT
	default: begin
     RegWrite   = 1'b0;
     ULAControl = 3'b0;
		end
	endcase	
	end

	7'b0010011: begin //Tipo I
	
	ULASrc = 1;
	RegWrite = 1;
	ULAControl = 3'b000;
	end
	default: begin
    RegWrite   = 1'b0;
    ULASrc     = 1'b0;
    ULAControl = 3'b000; 
     end
	endcase
end
endmodule