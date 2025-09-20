module Data_mem (

input logic [9:0] A,
input logic [31:0] WD,
input logic rst, WE, clk,
output logic [31:0] RD

);

//matriz memoria
logic [31:0] mem [0:31];
integer i;


// Lógica de Escrita e Reset (SEQUENCIAL)
always @ (posedge clk or negedge rst)
begin
		if (!rst) // EM verilog nao podemos mudar todos os arrays de uma vez
		begin
			for(i=0;i<32;i=i+1)
			begin
			mem[i]<=32'b0;
			end

		end
		else if (WE==1)
			mem[A]<=WD;
		
end

// Lógica de Leitura (COMBINACIONAL)
assign RD = mem[A];

endmodule 