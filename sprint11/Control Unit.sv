module Control_Unit(
	// Entradas
	input [6:0] OP,
	input  logic [2:0] Funct3,
	input  logic [6:0] Funct7,
	
	// Saídas
	output logic RegWrite,
	output logic [1:0] ImmSrc,    
	output logic ULASrc,
	output logic [2:0] ULAControl,
	output logic MemWrite,
	output logic ResultSrc,
	output logic Branch,   
	output logic BranchCond // NOVO: 0=Usa Z (BEQ), 1=Usa ~Z (BNE)	-----nova instrução
);
	always_comb begin
		// Define valores padrão para todos os sinais
		RegWrite   = 1'b0;
		ULASrc     = 1'b0;
		ULAControl = 3'b000; 
		ImmSrc     = 2'b00;
		MemWrite   = 1'b0;
		ResultSrc  = 1'b0;
		Branch     = 1'b0; 
		BranchCond = 1'b0; // -----nova instrução
		
		case(OP)
			7'b0110011: begin // TIPO R
				RegWrite   = 1'b1;
				ULASrc     = 1'b0;
				MemWrite   = 1'b0;
				ResultSrc  = 1'b0;
				Branch     = 1'b0;
				ImmSrc     = 2'bxx; 
				
                case({Funct3, Funct7})
               {3'b000, 7'b0000000}: ULAControl = 3'b000; // ADD
               {3'b000, 7'b0100000}: ULAControl = 3'b001; // SUB
               {3'b111, 7'b0000000}: ULAControl = 3'b010; // AND
               {3'b110, 7'b0000000}: ULAControl = 3'b011; // OR
               {3'b010, 7'b0000000}: ULAControl = 3'b101; // SLT
                default: ULAControl = 3'b0;
                endcase
                end

			7'b0010011: begin // TIPO I 
				RegWrite   = 1'b1;
				ULASrc     = 1'b1;
				ImmSrc     = 2'b00; 
				MemWrite   = 1'b0;
				ResultSrc  = 1'b0;
				Branch     = 1'b0;
				
				case (Funct3)
             3'b000: ULAControl = 3'b000; // ADDI ----nova instrução
             3'b111: ULAControl = 3'b010; // ANDI ----nova instrução
				 3'b110: ULAControl = 3'b011;  // ORI ----nova instrução
				 3'b100: ULAControl = 3'b100;  // XORI ----nova instrução
             default: RegWrite = 1'b0;    // Instrução inválida, não escreve
             endcase
			end
			
			7'b0000011: begin // TIPO I (LW)
				RegWrite   = 1'b1;
				ULASrc     = 1'b1;
				ULAControl = 3'b000;
				ImmSrc     = 2'b00; 
				MemWrite   = 1'b0;
				ResultSrc  = 1'b1;
				Branch     = 1'b0;
			end

			7'b0100011: begin // TIPO S (SW)
				RegWrite   = 1'b0;
				ULASrc     = 1'b1;
				ULAControl = 3'b000;
				ImmSrc     = 2'b01; 
				MemWrite   = 1'b1;
				ResultSrc  = 1'bx; 
				Branch     = 1'b0;
			end
			
			// --- NOVO BLOCO PARA O BEQ ---
			7'b1100011: begin 
				RegWrite   = 1'b0;
				ULASrc     = 1'b0;
				ULAControl = 3'b001; 
				ImmSrc     = 2'b10;
				MemWrite   = 1'b0;
				ResultSrc  = 1'bx; 
				Branch     = 1'b1; 
				
				case(Funct3)
				3'b000: BranchCond = 1'b0; // BEQ: usa a flag Z normal  
				3'b001: BranchCond = 1'b1; // BNE: usa a flag Z invertida   nova instrução
            default: Branch = 1'b0;   // Desvio inválido, não faz nada
            endcase
			end
			
			
			default: begin
		RegWrite   = 1'b0;
		ULASrc     = 1'b0;
		ULAControl = 3'b000; // Padrão seguro
		ImmSrc     = 2'b00;
		MemWrite   = 1'b0;
		ResultSrc  = 1'b0;
		Branch     = 1'b0;
			end
		endcase
	end
endmodule