module SDP();
	wire [31:0]C1;
	wire [31:0]C2;
	wire [31:0]C3;
	wire [31:0]C4;
	wire [4:0]C5;
	wire [31:0]C6;
	wire [31:0]C7;
	wire [31:0]C8;
	wire [3:0]C9;
	wire UCwire1,UCwire2,UCwire3,UCwire4,UCwire5,UCwire6,UCwire7,UCwire8;
	wire [31:0]CA1;
	wire CA2;
	wire [31:0]CA3;
	wire CA4;
	reg Clk;
	
	PC ProgramCounter(
					.PCNext(C3),
					.PCResult(C1),
					.Clk(Clk));
	
	Add4 Adder(
				.Entrada(C1),
				.Sal(C2));
	
	Mux2a1 MUX1(
				.D1(),
				.D2(C2),
				.SD(CA4),
				.Salida(C3));
	
	MemIns MI(	
				.Dato(),
				.Address(C1),
				.Instruccion(C4));
	
	Mux2a15B MUX2(
				.D1(C4[14:11]),
				.D2(C4[20:16]),
				.SD(UCwire1),
				.Salida(C5));
	
	UnidadControl UC(
				.Opcode(C4[31:26]),
				.RegDst(UCwire1),
				.Branch(UCwire2),
				.MemRead(UCwire3),
				.MemToReg(UCwire4),
				.ALUOp(UCwire5),
				.MemToWrite(UCwire6),
				.ALUSrc(UCwire7),
				.RegWrite(UCwire8));
	
	Registros BR(
				.RA1(C4[25:21]),
				.RA2(C4[20:16]),
				.Dir(C5),
				.en(UCwire8),
				.Dw(CA3),
				.S1(C6),
				.S2(C7));
	
	Mux2a1 MUX3(
				.D1(),
				.D2(C7),
				.SD(UCwire7),
				.Salida(C8));
	
	ALU alu(
			.OP1(C6),
			.OP2(C8),
			.Sel(C9),
			.Resultado(CA1),
			.ZF(CA2));
	
	AluControl AC(
				  .Func(C4[5:0]),
				  .AluOP(UCwire5),
				  .AluFunc(C9));
	
	Mux2a1 MUX4(
				.D1(),
				.D2(CA1),
				.SD(UCwire4),
				.Salida(CA3));
	
	assign CA4 = UCwire2 & CA2;
	
	initial 
		begin
			Clk = 1'b0;
			forever #100
			Clk = ~Clk;
		end
	
endmodule
