
module adder_32bit(
    input  logic [31:0] A_in,
    input  logic [31:0] B_in,
    output logic [31:0] Sum_out
);
    assign Sum_out = A_in + B_in;

endmodule