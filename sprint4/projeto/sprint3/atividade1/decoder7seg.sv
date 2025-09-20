module decoder7seg (
    input  logic [3:0] In,  // 4-bit hexadecimal input (0-F)
    output logic [6:0] Out  
);

    always_comb begin
        case (In)
            4'h0: Out = ~7'b0111111; // 0 
            4'h1: Out = ~7'b0000110; // 1
            4'h2: Out = ~7'b1011011; // 2
            4'h3: Out = ~7'b1001111; // 3
            4'h4: Out = ~7'b1100110; // 4
            4'h5: Out = ~7'b1101101; // 5
            4'h6: Out = ~7'b1111101; // 6
            4'h7: Out = ~7'b0000111; // 7
            4'h8: Out = ~7'b1111111; // 8
            4'h9: Out = ~7'b1101111; // 9
            4'hA: Out = ~7'b1110111; // A 
            4'hB: Out = ~7'b1111100; // B 
            4'hC: Out = ~7'b0111001; // C 
            4'hD: Out = ~7'b1011110; // D 
            4'hE: Out = ~7'b1111001; // E 
            4'hF: Out = ~7'b1110001; // F 
            default: Out = ~7'b0000000; 
        endcase
    end

endmodule

