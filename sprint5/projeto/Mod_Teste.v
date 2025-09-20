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

//constantes fixas
wire we3_fixo = 1'b1;
wire [2:0] ra2_fixo = 3'b010;
wire [7:0] constant_in = 8'h07;

    // Fios para as entradas/saídas da ULA
wire [31:0] w_rd1SrcA;      // Conecta rd1 a SrcA da ULA
wire [31:0] w_SrcB; // Saída do MUX para SrcB da ULA
wire [31:0] w_ULAResultWd3; // Saída ULAResult da ULA

registerfile reg_file_inst (
        .clk (KEY[1]),
        .rst (KEY[2]),
        .we3 (we3_fixo),      
        .wa3 (SW[16:14]),    
        .wd3 (SW[7:0]), 
        .ra1 (SW[13:11]),
        .ra2 (ra2_fixo),
        .rd1 (w_d0x0[7:0]),      // Saída 1
        .rd2 (w_d1x0[7:0])       // Saída 2
    );

assign w_rd1SrcA = w_d0x0[7:0]; // rd1 conecta a SrcA da ULA	  
///////////////////MUX///////////////////////////////////
assign w_SrcB = SW[17] ? constant_in :  w_d1x0[7:0];
/////////////////////////////////////////////////////
assign w_d1x1[7:0] = w_SrcB;

ULA inst1 (
        .SrcA (w_rd1SrcA),                 //conectado a rd1 
        .SrcB (w_SrcB),         // Conectado à saída do MUX 2x1
        .ULAcontrol (SW[10:8]),           // ULAControl dos SW
        .ULAresult (w_ULAResultWd3),       // Saída da ULA
        .Z (LEDG[0])    
);		  
assign w_d0x4 = w_ULAResultWd3;

	
//decodificador
	wire [3:0] sw_upper_nibble = SW[7:4];
   wire [3:0] sw_lower_nibble = SW[3:0];
	
	decoder hex0_inst(.In(sw_lower_nibble), .Out(HEX0));
	decoder hex1_inst(.In(sw_upper_nibble), .Out(HEX1));
	

endmodule