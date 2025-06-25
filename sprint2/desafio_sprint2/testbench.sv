// Code your testbench here
// or browse Examples
module contador16_t;
  
  //sinais
  
  logic clk;
  logic reset;
  logic dir_cont;
  logic [3:0] contagem_out;
  logic enable_contador;
  // instanciação
  
  contador16 inst1( clk, reset, dir_cont,enable_contador, contagem_out );
  
  always #5 clk = ~clk;
  
  initial
    begin
     // 1. Inicialização dos sinais no tempo 0 para evitar valores 'X' (indefinidos)
        clk = 0;
        reset = 1;// Reset inicialmente desativado (nível alto)
        enable_contador = 0; // Contador inicialmente desabilitado
        dir_cont = 0;      // Direção inicial: Crescente

        // 3. Sequência de Teste

        $display("Tempo %0t: Inicio da simulacao do Contador.", $time);
        #10; // Pequeno atraso inicial para estabilização

        // --- Cenario 1: Teste de Reset Assincrono ---
        $display("Tempo %0t: --- Teste de Reset Assincrono ---", $time);
        reset = 0; // Ativa o reset (vai zerar a contagem imediatamente)
        #10;       // Mantém o reset ativo por 10ns
        reset = 1; // Desativa o reset

        // --- Cenario 2: Contagem Crescente (0-F) ---
        enable_contador = 1; // Habilita o contador
        dir_cont = 0;        // Define a direção como crescente
        $display("Tempo %0t: --- Teste de Contagem Crescente (0-F) ---", $time);
        $display("Tempo %0t: Habilitando contador crescente. Valor inicial: %h", $time, contagem_out);

        // Contar por mais de 16 ciclos para verificar o wrap-around (0->F->0->1...)
        for (int i = 0; i < 20; i++) begin
            #10; // Aguarda um ciclo de clock completo
            $display("Tempo %0t: Contagem = %h (Esperado: %h)", $time, contagem_out, (i < 16 ? i : (i - 16)));
        end
        $display("Tempo %0t: Fim do teste de contagem crescente.", $time);


         //ario 3: Teste de Desabilitar Contador (Enable = 0) ---
        enable_contador = 0; // Desabilita o contador
        $display("Tempo %0t: --- Teste de Desabilitar Contador (Enable = 0) ---", $time);
        $display("Tempo %0t: Desabilitando contador. Contagem deve manter %h.", $time, contagem_out);
        #30; // Aguarda 3 ciclos. A contagem NÃO deve mudar.
        $display("Tempo %0t: Fim do teste de desabilitar contador.", $time);


        // --- Cenario 4: Contagem Decrescente (F-0) ---
        // Primeiro, forçamos um reset para 0, para termos um ponto de partida conhecido.
        $display("Tempo %0t: --- Teste de Contagem Decrescente (F-0) ---", $time);
        $display("Tempo %0t: Aplicando Reset para 0 antes da contagem decrescente.", $time);
        reset = 0; // Reset para 0
        #10;
        reset = 1;

        enable_contador = 1; // Habilita o contador
        dir_cont = 1;        // Define a direção como decrescente
        $display("Tempo %0t: Habilitando contador decrescente. Valor inicial: %h", $time, contagem_out);

        // Contar por mais de 16 ciclos para verificar o wrap-around (0->F->E...)
        for (int i = 0; i < 20; i++) begin
            #10; // Aguarda um ciclo de clock completo
            $display("Tempo %0t: Contagem = %h", $time, contagem_out);
        end
        $display("Tempo %0t: Fim do teste de contagem decrescente.", $time);

        // --- Finalização da Simulação ---
        $display("Tempo %0t: Fim da simulacao do Contador.", $time);
        #20; // Pequeno atraso final antes de terminar a simulação
        $finish; // Termina a simulação
    end
    
  
  initial begin
     $dumpfile("test.vcd");
    $dumpvars(0, inst1);
   end
  
  
endmodule