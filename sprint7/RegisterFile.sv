module registerfile (
	input logic clk, rst, we3,
	input logic [4:0] wa3, ra1, ra2,
	input logic [31:0] wd3,
	output logic [31:0] rd1, rd2,
	
	// Saídas auxiliares para debug
    output logic [31:0]  debug_x0,
    output logic [31:0]  debug_x1,
    output logic [31:0]  debug_x2,
    output logic [31:0]  debug_x3,
    output logic [31:0]  debug_x4,
    output logic [31:0]  debug_x5,
    output logic [31:0]  debug_x6,
    output logic [31:0]  debug_x7
);

logic [31:0] registers [31:0];

assign rd1 = (ra1 == 5'b0) ? 32'b0 : registers[ra1];
assign rd2 = (ra2 == 5'b0) ? 32'b0 : registers[ra2];

always_ff @(posedge clk or negedge rst) begin
	if (rst==0) begin
		for (int i = 0; i < 32; i++)
			registers[i] <= 32'd0;
	end
		
	else if(we3 && (wa3 != 5'd0))
		registers[wa3] <= wd3;
end

// --- LIGAÇÕES DE DEBUG (RE-ADICIONADAS) ---
    
assign debug_x0 = registers[0];
assign debug_x1 = registers[1];
assign debug_x2 = registers[2];
assign debug_x3 = registers[3];
assign debug_x4 = registers[4];
assign debug_x5 = registers[5];
assign debug_x6 = registers[6];
assign debug_x7 = registers[7];


endmodule