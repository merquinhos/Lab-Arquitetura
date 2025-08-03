// Módulo da Memória de Instruções usando um decodificador com 'case'
module instruction_memory_case (
    input  logic [31:0] A,   // Entrada de Endereço (do PC)
    output logic [31:0] RD  // Saída de Instrução (para o datapath)
);

    always_comb begin
        // obter o endereço da palavra (dividindo por 4).
        case (A[31:2])
            'h00: RD = 32'h0f300093; // Endereço de byte 0x00
            'h01: RD = 32'h00900113; // Endereço de byte 0x04
            'h02: RD = 32'h00208133; // Endereço de byte 0x08
            'h03: RD = 32'h0020f1b3; // Endereço de byte 0x0C
            'h04: RD = 32'h0020e233; // Endereço de byte 0x10
            'h05: RD = 32'h0041a333; // Endereço de byte 0x14
            'h06: RD = 32'h406203b3; // Endereço de byte 0x18
            
            default: RD = 32'h00000000;
        endcase
    end

endmodule


