module Extends (
	input logic [12:0] imediato,
	output logic [31:0] extensao_de_sinal
);

    // Concatenação
    assign extensao_de_sinal = {{19{imediato[12]}}, imediato};

endmodule