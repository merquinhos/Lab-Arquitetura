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

    // ---Sinais principais de controle---

wire rst;
wire clk;

    //--- Fios do Caminho de Dados (Datapath)---
wire [31:0] w_mimm , w_Imm, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResult, w_Inst, w_PCp4, w_PC, w_RData, w_memWrite, w_ResultSrc, w_Wd3, w_immSrc ;
wire w_Z_flag;


    //--- Fios dos Sinais de Controle---
wire w_ULASrc, w_RegWrite;
wire [2:0] w_ULAControl;
	 
// --- Atribuições de Sinais ---

//assign clk = KEY[1];
assign rst = KEY[3]; 
assign LEDG[7] = KEY[3];
	 
//ligações auxiliares Debug
assign w_d0x4 = w_PC; // PC na posição d0x4 do LCD
	  
// Instanciações dos 8 decodificadores para os displays HEX
decoder d0 (.In(w_Inst[3:0]),   .Out(HEX0));
decoder d1 (.In(w_Inst[7:4]),   .Out(HEX1));
decoder d2 (.In(w_Inst[11:8]),  .Out(HEX2));
decoder d3 (.In(w_Inst[15:12]), .Out(HEX3));
decoder d4 (.In(w_Inst[19:16]), .Out(HEX4));
decoder d5 (.In(w_Inst[23:20]), .Out(HEX5));
decoder d6 (.In(w_Inst[27:24]), .Out(HEX6));
decoder d7 (.In(w_Inst[31:28]), .Out(HEX7));

	 
// leds:
assign LEDR[0] = w_ResultSrc;
assign LEDR[1] = w_memWrite;
assign LEDR[4:2] = w_ULAControl;
assign LEDR[5] = w_ULASrc;
assign LEDR[6] = w_immSrc;
assign LEDR[7] = w_RegWrite;
 
 
 // 11. modulo divisor de frequencia
frequency_divider hdjhff (
		.clock_50Mhz (CLOCK_50),
		.clock_1hz(clk)
);
	 // 1. Lógica do Program Counter
 Program_Counter u_pc (
        .clk(clk),
        .rst(rst),
        .PC(w_PCp4),
        .PC_out(w_PC)
);
	 
adder_4 u_adder4 (
        .PC_in(w_PC),
        .PC_plus_4_out(w_PCp4)
);
	 
// 2. Memória de Instruções
instruction_memory_case u_memory (
        .a(w_PC),
        .rd(w_Inst)
);
	 // 3. Unidade de Controle
Control_Unit u_ctrl (
      .OP(w_Inst[6:0]),
      .Funct3(w_Inst[14:12]),
      .Funct7(w_Inst[31:25]),
      .ULAControl(w_ULAControl[2:0]),
      .ULASrc(w_ULASrc),
      .RegWrite(w_RegWrite),
		.ImmSrc (w_immSrc),
		.MemWrite(w_memWrite),
		.ResultSrc(w_ResultSrc)
 );
	 
// 4. Banco de Registradores
registerfile u_regfile (
        .clk(clk),
        .rst(rst),
        .we3(w_RegWrite),
        .ra1(w_Inst[19:15]),
        .ra2(w_Inst[24:20]),
        .wa3(w_Inst[11:7]),
        .wd3(w_Wd3),
        .rd1(w_rd1SrcA),
        .rd2(w_rd2),
		  .debug_x0(w_d0x0),
        .debug_x1(w_d0x1),
        .debug_x2(w_d0x2),
        .debug_x3(w_d0x3),
        .debug_x4(w_d1x0), 
        .debug_x5(w_d1x1),
        .debug_x6(w_d1x2),
        .debug_x7(w_d1x3)
    );
	 
	 // 5. Multiplexador 1
mux_2x1 uio(

		.entrada_c(w_Inst[31:20]),
		.entrada_d({w_Inst[31:25], w_Inst[11:7]}),
		.sel1(w_immSrc),
		.resul1(w_mimm)

);

	 // 6. Unidade de Extensão de Sinal
Extends uu_extend (
        .imediato(w_mimm),
        .extensao_de_sinal(w_Imm)
);
	  

// 7. Multiplexador 2 
assign w_SrcB = w_ULASrc ? w_Imm  :  w_rd2;

// 8. Unidade Lógica e Aritmética (ULA)
ULA u_alu (
        .SrcA(w_rd1SrcA),
        .SrcB(w_SrcB),
        .ULAcontrol(w_ULAControl),
        .ULAresult(w_ULAResult),
        .Z(w_Z_flag)
);

// 9. intancia da Data Memory
Data_mem memoria(
		.A(w_ULAResult),
		.WD(w_rd2),
		.rst(rst),
		.WE(w_memWrite),
		.clk(clk),
		.RD(w_RData)
);

// 10. Multiplexador 3 
assign w_Wd3 = w_ResultSrc ? w_RData  :  w_ULAResult;


endmodule