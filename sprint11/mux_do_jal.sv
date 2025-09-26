module mux_3_to_1 (
    input  logic [31:0] x1,
    input  logic [31:0] x2,
    input  logic [31:0] x3,
    input  logic [12:0] x4,
    output logic [12:0] y1
);
    always_comb begin
        case (x4)
            2'b00:   y1 = x1; // Resultado da ULA
            2'b01:   y1 = x2; // Dado da Memória
            2'b10:   y1 = x3; // PC + 4 para o JAL
            default: y1 = {32{1'bx}};
        endcase
    end
endmodule