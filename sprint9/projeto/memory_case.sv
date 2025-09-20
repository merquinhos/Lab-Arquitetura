// Módulo da Memória de Instruções usando um decodificador com 'case'
module instruction_memory_case (
    input  logic [31:0] a,   // Entrada de Endereço (do PC)
    output logic [31:0] rd  // Saída de Instrução (para o datapath)
);

    always_comb begin
        // obter o endereço da palavra (dividindo por 4).
        case (a[31:2])
		  
				32'h00: rd = 32'h00100293; 
				32'h02: rd = 32'h0fc02103; // 
				32'h03: rd = 32'h00110113; // 
				32'h04: rd = 32'h00517333; // 
				32'h05: rd = 32'h0e602e23; // 
				32'h06: rd = 32'hfe0006e3; 
				 
            
            default: rd = 32'h00000000;
        endcase
    end

endmodule



































/*
				32'h00: rd = 32'hfc002283; // lw  x5, 0xFC(x0)
				32'h01: rd = 32'h0012f313; // andi x6, x5, 1
				32'h02: rd = 32'h00134393; // xori x7, x6, 1
				32'h03: rd = 32'h00702ee3; // sw  x7, 0xFC(x0)
				32'h04: rd = 32'hff1ff06f; // jal x0, 0
		
		*/