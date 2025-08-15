module Extends (
	input logic [11:0] imediato,
	output logic [31:0] extensao_de_sinal
);

    // Concatenação
    assign extensao_de_sinal = {{20{imediato[11]}}, imediato};

endmodule