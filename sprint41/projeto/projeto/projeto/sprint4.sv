
// Módulo para o decodificador de 3 para 8 bits
module Decoder_5_to_32 (
    input logic [4:0] write_address,
	 output reg [31:0] decoded_output 
);
    always @(*) begin
        // Inicializa todas as saídas para 0
        decoded_output = 32'b00000000;

        case (write_address)
            5'b000: decoded_output[0] = 1'b1; 
            5'b001: decoded_output[1] = 1'b1; 
            5'b010: decoded_output[2] = 1'b1; 
            5'b011: decoded_output[3] = 1'b1; 
            5'b100: decoded_output[4] = 1'b1; 
            5'b101: decoded_output[5] = 1'b1; 
            5'b110: decoded_output[6] = 1'b1; 
            5'b111: decoded_output[7] = 1'b1; 
            default: decoded_output = 32'b00000000; 
        endcase
    end
endmodule

// Módulo do registrador
module Registrador_32bit(
	input logic clk, 
  	input logic reset,
  	input logic enable,
  	input logic [31:0] in, 
  	output reg [31:0] out
);
  
  always @(posedge clk or negedge reset)
    begin
      if(!reset)
        out <= 0;
    else if (enable) 
        out <= in;
      else
        out <= out;        
  end
endmodule

// Definição de parâmetros
`define NUM_REGS 32 //numeros de registradores
`define ADDR_WIDTH 5 //largura do endereço
`define DATA_WIDTH 32 // Largura dos dados

module RegisterFile(
	input logic clk,
   input logic rst,
   input logic we3, 
   input logic [(`ADDR_WIDTH-1):0] wa3, 
   input logic [31:0] wd3, 
   input logic [(`ADDR_WIDTH-1):0] ra1, 
   input logic [(`ADDR_WIDTH-1):0] ra2, 
   output logic [31:0] rd1, 
   output logic [31:0] rd2  
);

   // Saídas do decodificador
   wire [`NUM_REGS-1:0] decoded_out; // Um bit para cada registrador
   

	// saída dos registradores
	wire [`DATA_WIDTH-1:0] registrador_output [`NUM_REGS-1:0];

	// entrada dos registradores
	wire [`NUM_REGS-1:0] load;
   // ----------------------------------------------------
   // 1. Instaciação do decodificador
   // ----------------------------------------------------
   Decoder_5_to_32 inst1(
        .decoded_output(decoded_out),
        .write_address(wa3)
   );

   // ----------------------------------------------------
   // 2. Instaciações das 32 Portas AND
   // ----------------------------------------------------
  
	genvar j;
	generate
	for (j=0; j< `NUM_REGS; j= j+1) begin:ands
		assign load[j] = we3 & decoded_out[j];
	
	end
	endgenerate
 
	///----------------------------------------------------
	///3. instaciações dos registradores
	///----------------------------------------------------

   genvar i;
	generate 
	for (i=0; i< `NUM_REGS; i= i+1) begin:resgister
	if (i == 0) begin
	 assign registrador_output[0] = 0;
	end
	else begin
		Registrador_32bit inst1 (
		.out(registrador_output[i]),
		.in(wd3),
		.clk(clk),
		.reset(rst),
		.enable(load[i])
		);
		end
	end
	endgenerate
   
	 
	 ///----------------------------------------------------
	 ///4. instaciações dos multiplexadores(MUX)
	 ///----------------------------------------------------

	 assign rd1 = registrador_output[ra1];
	 assign rd2 = registrador_output[ra2];

	 
endmodule