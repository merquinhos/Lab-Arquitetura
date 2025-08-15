// Módulo da Memória de Instruções usando um decodificador com 'case'
module instruction_memory_case (
    input  logic [31:0] a,   // Entrada de Endereço (do PC)
    output logic [31:0] rd  // Saída de Instrução (para o datapath)
);

    always_comb begin
        // obter o endereço da palavra (dividindo por 4).
        case (a[31:2])
				32'h00: rd = 32'h0AB00093; // addi x1, x0, 0xAB 
				32'h01: rd = 32'h00102523; // sw   x1, 0xA(x0)
				32'h02: rd = 32'h00A02103; // lw x2, 0xA(x0) 
				32'h03: rd = 32'h002025A3; // sw x2, 0xB(x0) 
				32'h04: rd = 32'h00B02183; // lw x3, 0xB(x0) 
				32'h05: rd = 32'h00302623; // sw x3, 0xC(x0) 
				32'h06: rd = 32'h00C02203; // lw x4, 0xC(x0)
            
            default: rd = 32'h00000000;
        endcase
    end

endmodule


