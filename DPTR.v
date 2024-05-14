`timescale 1ns/1ns
module DPTR(
			input [31:0]ITR,
			output TR_ZF);
	wire [31:0]C1;
	wire [31:0]C2;
	wire [31:0]C3;
	wire [2:0]C4; 
	wire [31:0]C5; 
	wire [3:0]C6;
	wire CA1; 
	wire CA2; 
	wire CA3; 
	wire [31:0]CA4;
	
	
	UnidadControl UC(
				.Opcode(ITR[31:26]),
				.MemToReg(CA1),
				.RegWrite(CA2),
				.MemToWrite(CA3),
				.ALUOp(C4));
	
	Registros BR(
				.RA1(ITR[25:21]),
				.RA2(ITR[20:16]),
				.Dir(ITR[15:11]),
				.en(CA2),
				.Dw(CA4),
				.S1(C2),
				.S2(C1));
	
	ALU alu(
			.OP1(C2),
			.OP2(C1),
			.Sel(C6),
			.Resultado(C3),
			.ZF(TR_ZF));
	
	AluControl AC(
				  .Func(ITR[5:0]),
				  .AluOP(C4),
				  .AluFunc(C6));
	
	Ram MEM(
			.Dato(C1),
			.Dir(C3),
			.Sel(CA3),
			.Salida(C5));
	
	Mux2a1 M(
				.D1(C5),
				.D2(C3),
				.SD(CA1),
				.Salida(CA4));
endmodule

module DPTR_TB();
	reg [31:0]ITR_TB;
	wire TR_ZF_TB;
	
	DPTR DUV(.ITR(ITR_TB),.TR_ZF(TR_ZF_TB));
	
initial
	begin
		$readmemb("Nums.txt", DUV.DPTR.BR.Registros.regs);
		$readmemb("carga.txt", DUV.DPTR.MEM.Ram.Dato1);
		//OPERACIONES
		ITR_TB = 32'b00000010000100010000000000100000;
		#100;
		ITR_TB = 32'b00000010100011110000100000100010;
		#100;
		ITR_TB = 32'b00000001011100110001000000101010;
		#100;
		ITR_TB = 32'b00000011100101010001100000100100;
		#100;
		ITR_TB = 32'b00000001101011000010000000100101;
		#100;
		ITR_TB = 32'b00000011000111010010100000100000;
		#100;
		ITR_TB = 32'b00000011000111010011000000100010;
		#100;
		ITR_TB = 32'b00000011111110100011100000101010;
		#100;
		ITR_TB = 32'b00000011001110110100000000100100;
		#100;
		ITR_TB = 32'b00000011110101110100100000100101;
		#100;
		$stop;
	end
	
endmodule