`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------


	RegisterFile reg_file_inst(.clk(KEY[1]), .we3(SW[17]), .wa3(SW[16:14]), .ra1(SW[13:11]), .ra2(SW[10:8]), .wd3(SW[7:0]), .rst(KEY[2]), 
	.rd1(w_d0x0[7:0]), .rd2(w_d0x1[7:0]));
	
	//ligações auxiliares
//	Registrador_8bit inst_hex0 (.in(SW[3:0]), .out(HEX0));
//	Registrador_8bit inst_hex1 (.in(SW[7:0]), .out(HEX1));

	wire [3:0] sw_upper = SW[7:4];
   wire [3:0] sw_lower = SW[3:0];
	
	decoder hex0_inst(.In(sw_lower), .Out(HEX0));
	decoder hex1_inst(.In(sw_upper), .Out(HEX1));
	
	
	assign LEDG[0] = ~KEY[1];
	
endmodule