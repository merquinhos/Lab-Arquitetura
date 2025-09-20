// Módulo da Memória de Instruções usando um decodificador com 'case'
module instruction_memory_case (
    input  logic [31:0] a,   // Entrada de Endereço (do PC)
    output logic [31:0] rd  // Saída de Instrução (para o datapath)
);

    always_comb begin
        // obter o endereço da palavra (dividindo por 4).
        case (a[31:2])
		  
				32'h00: rd = 32'h00100513; 
				32'h01: rd = 32'h10000593;  
				32'h02: rd = 32'h00a00613;  
				32'h03: rd = 32'h0fc02283;  
				32'h04: rd = 32'h00a28663;  
				32'h05: rd = 32'h0e002e23; 
				32'h06: rd = 32'hfe000ae3;
				32'h07: rd = 32'h00100313;
				32'h08: rd = 32'h0fc02283;
				32'h09: rd = 32'h00a28463;
				32'h0a: rd = 32'hfe0006e3;
				32'h0b: rd = 32'h0e602e23;
				32'h0c: rd = 32'h00060433;
				32'h0d: rd = 32'hfff40413;
				32'h0e: rd = 32'h00040463;
				32'h0f: rd = 32'hfe000ce3;
				32'h10: rd = 32'h00630333;
				32'h11: rd = 32'hfcb30ce3;
				32'h12: rd = 32'hfc000ce3;
				 
            
            default: rd = 32'h00000000;
        endcase
    end

endmodule








/*

# Programa de Animação de LED Interativo
#
# x5: Valor lido dos switches
# x6: Padrão do LED atual (ex: 00000001)
# x8: Contador do loop de delay
# x10: Constante 1
# x11: Constante 256 (para saber quando a animação terminou o ciclo)
# x12: Valor do delay

.globl _start
_start:
    addi x10, x0, 1         # x10 = 1 (para comparação)
    addi x11, x0, 256       # x11 = 256 (valor de reset da animação)
    addi x12, x0, 20000     # x12 = 20000 (duração do delay)

main_loop: # Endereço 0x0C
    lw x5, 0xfc(x0)         # Lê os switches
    beq x5, x10, start_anim # Se a entrada for 1, começa a animar
    sw x0, 0xfc(x0)         # Se não for 1, apaga todos os LEDs
    beq x0, x0, main_loop   # Volta a verificar

start_anim: # Endereço 0x18
    addi x6, x0, 1          # Inicia a animação com o LED 0 (padrão 00000001)

anim_loop: # Endereço 0x1C
    # VERIFICAÇÃO DE PARADA DENTRO DO LOOP
    lw x5, 0xfc(x0)         # Lê os switches novamente
    beq x5, x10, continue_anim # Se ainda for 1, continua
    beq x0, x0, main_loop      # Se mudou, aborta e vai para o loop principal

continue_anim: # Endereço 0x28
    sw x6, 0xfc(x0)         # Acende o LED da vez

    # Loop de Delay
    add x8, x12, x0         # Inicia o contador de delay
delay_loop: # Endereço 0x30
    addi x8, x8, -1
    beq x8, x0, end_delay   # Se o contador for 0, sai do delay
    beq x0, x0, delay_loop  # Se não, continua no delay
end_delay: # Endereço 0x38

    # Avança para o próximo LED (shift left por meio de uma soma)
    add x6, x6, x6

    # Verifica se o ciclo de 8 LEDs terminou
    beq x6, x11, start_anim # Se o padrão se tornou 256, recomeça do início
    
    # Se não terminou, continua o loop da animação
    beq x0, x0, anim_loop
	 
	 */