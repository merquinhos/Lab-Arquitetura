
module Parallel_OUT (
    input  logic clk,
	 input  logic rst,
    input  logic EN,
    input  logic [31:0] Address,   
    input  logic [7:0] RegData,   
    output logic [7:0] DataOut    
);
	logic address_match;
   logic register_enable;
    
   // Lógica do Comparador
    assign address_match = (Address[7:0] == 8'hFC);

    // Lógica da Porta AND
    assign register_enable = EN & address_match;

	// Lógica do Registrador Síncrono de 8 bits
    always_ff @(posedge clk or negedge rst) begin
        // O reset é assíncrono e tem prioridade máxima
        if (!rst) begin
            DataOut <= 8'b0; 
        end
        else if (register_enable) begin
            DataOut <= RegData;
        end
        // Se 'rst' for 0 e 'register_enable' for 0, a saída mantém seu valor antigo.
    end

endmodule