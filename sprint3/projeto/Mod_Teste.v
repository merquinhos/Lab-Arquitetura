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

//atividade 1

//assign LEDG[0] = ~KEY[0];
//assign LEDG[1] = ~KEY[1];

//atividade2
/*
	assign HEX0[0] = SW[0]; 
   assign HEX0[1] = SW[1]; 
   assign HEX0[2] = SW[2]; 
   assign HEX0[3] = SW[3]; 
   assign HEX0[4] = SW[4]; 
   assign HEX0[5] = SW[5]; 
   assign HEX0[6] = SW[6]; 
	
	*/
	/*
	ATIVIDADE3
	decoder7seg inst1(.In(SW[11:8]), .Out(HEX3[6:0]));
	*/
	
	//ultima atividade
	wire [3:0]out_registrador;
	decoder inst1(.In(out_registrador), .Out(HEX3[6:0]));
	registrador inst2(.in(SW[11:8]), .clk(SW[17]),.reset(SW[16]),.enable(SW[15]), .out(out_registrador));
	
endmodule