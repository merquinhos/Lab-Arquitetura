
module adder_4 (
    input  logic [31:0] PC_in,
    output logic [31:0] PC_plus_4_out
);

    // A saída é sempre a entrada mais 4.
    assign PC_plus_4_out = PC_in + 3'h4;

endmodule

