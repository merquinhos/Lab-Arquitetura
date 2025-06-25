// Code your testbench here
// or browse Examples

module resgistrador_t;
  
 	//sinais 
	logic clk;
	logic reset;
  	logic enable;
  	logic [3:0]in;
  	reg [3:0]out;

// Instância do módulo
  registrador inst1( clk, reset,enable, in, out);
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0; // Inicializa o clock para evitar 'X'
    reset = 1; // Deassert reset
    enable = 1; // Começa com enable ativo para registrar dados
    in = 4'b0000;

    #10; // Deixa o sistema estabilizar um pouco, talvez um ou dois ciclos

    reset = 0; // Ativa o reset (borda de descida) para zerar o registrador
    #5;       // Mantém o reset por um tempo
    reset = 1; // Desativa o reset

    #5; // Espera um pouco, talvez até a próxima borda de clock

    // Teste de registro com enable = 1
    enable = 1;
    in = 4'b1010; // Este dado deve ser registrado no próximo posedge clk
    #10;          // Aguarda um ciclo completo (dado já deveria ter sido registrado)

    in = 4'b0001; // Este dado deve ser registrado no próximo posedge clk
    #10;

    // Teste de retenção com enable = 0
    enable = 0;
    in = 4'b1111; // Este dado NÃO deve ser registrado, o valor anterior (0001) deve ser mantido
    #10;

    in = 4'b0101; // Este dado TAMBÉM NÃO deve ser registrado
    #10;

    // Ativa o enable novamente para registrar o último valor de In_data (0101)
    enable = 1;
    #10; // Agora 0101 deve ser registrado

    #25 $finish; // Termina a simulação
end
  
  initial begin
     $dumpfile("test.vcd");
    $dumpvars(0, inst1);
   end
  
endmodule