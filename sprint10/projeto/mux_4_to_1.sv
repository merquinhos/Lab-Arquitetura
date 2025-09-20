
module mux_4_to_1 (

    input  logic [12:0] d00,
    input  logic [12:0] d01,
    input  logic [12:0] d10,
    input  logic [12:0] d11,
    input  logic [1:0] sel,
    output logic [12:0] y
);
    always_comb begin
        case (sel)
            2'b00:   y = d00;
            2'b01:   y = d01;
            2'b10:   y = d10;
            2'b11:   y = d11;
            default: y = {13{1'bx}}; 
        endcase
    end

endmodule