module registerfile (
	input logic clk, rst, we3,
	input logic [4:0] wa3, ra1, ra2,
	input logic [31:0] wd3,
	output logic [31:0] rd1, rd2
);

logic [31:0] registers [31:0];

assign rd1 = registers[ra1];
assign rd2 = registers[ra2];

always_ff @(posedge clk or negedge rst) begin
	if (rst==0) begin
		for (int i = 0; i < 32; i++)
			registers[i] <= 32'd0;
	end
		
	else if(we3 && (wa3 != 5'd0))
		registers[wa3] <= wd3;
end


endmodule