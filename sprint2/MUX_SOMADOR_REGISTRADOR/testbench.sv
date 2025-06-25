// Code your testbench here
// or browse Examples

module muxSomadorRegistrador_t;
   //sinais
  logic [3:0] A;
  logic [3:0] B;
  logic [3:0] C;
  logic S;
  logic CLK;
  logic RESET;
  logic ENABLE;
  logic [3:0] RES;
  
  // Instância do módulo
  muxSomadorRegistrador inst1(A,B,C,S,CLK, RESET,ENABLE, RES);
  
  always #5 CLK = ~CLK;
  
  initial begin
    CLK = 0; // Inicializa o clock para evitar 'X'
    S = 1;
    RESET = 1; // Deassert reset
    ENABLE = 1; // Começa com enable ativo para registrar dados
    S = 1;
    A = 4'b0000;
    B = 4'b0001;
	C = 4'b0101;
    #10; // Deixa o sistema estabilizar um pouco, talvez um ou dois ciclos

    RESET = 0; // Ativa o reset (borda de descida) para zerar o registrador
    #5;       // Mantém o reset por um tempo
    RESET = 1; // Desativa o reset

    #5; // Espera um pouco, talvez até a próxima borda de clock

    // Teste de registro com enable = 1
    ENABLE = 1;
    A = 4'b1010; // Este dado deve ser registrado no próximo posedge clk
    #10;          // Aguarda um ciclo completo (dado já deveria ter sido registrado)

    A = 4'b0001; // Este dado deve ser registrado no próximo posedge clk
    #10;

    // Teste de retenção com enable = 0
    S= 0;
    ENABLE = 0;
    A = 4'b0010; // Este dado NÃO deve ser registrado, o valor anterior (0001) deve ser mantido
    #10;
; // Este dado TAMBÉM NÃO deve ser registrado

    // Ativa o enable novamente para registrar o último valor de In_data (0101)
    ENABLE = 1;
    #10; // Agora 0101 deve ser registrado

    #25 $finish; // Termina a simulação
end
  
  initial begin
     $dumpfile("test.vcd");
    $dumpvars(0, inst1);
   end
  
endmodule
