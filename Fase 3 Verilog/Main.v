`timescale 1ns/1ns
module Main();
	
	wire [31:0]AddressWire;
	wire [31:0]InsWire;
	wire [3:0]AluFuncWire;
	wire RegDstWire,BranchWire,MemReadWire,MemToRegWire,MemToWriteWire,ALUSrcWire,JumpWire, RegWriteWire;
	wire ZFwire;
	wire [1:0]ALUOpWire;
	wire [31:0]extendedWire;
	wire [31:0]extendedShifted;
	wire [31:0]PCinWire;
	wire [31:0]AddressPlus4;
	wire [31:0]AdderResult;
	wire [31:0]Mux4Result;
	wire [31:0]Mux3Result;
	wire [4:0]Mux2Result;
	wire [31:0]Mux1Result;
	wire [31:0]S1Wire;
	wire [31:0]S2Wire;
	wire [31:0]AluResult;
	wire [31:0]RamOut;
	wire [27:0]ShiftLeftResult;
	wire BranchAndZF;
	reg Clk;
	
	Add4 A4(
			.Entrada(AddressWire),
			.Sal(AddressPlus4));
	
	Adder ADD(
			.E1(AddressPlus4),
			.E2(extendedShifted),
			.Sal(AdderResult));
	
	ALU A(
			.OP1(S1Wire),
			.OP2(Mux3Result),
			.Sel(AluFuncWire),
			.Resultado(AluResult),
			.ZF(ZFwire));
	
	AluControl AC(
			.Func(InsWire[5:0]),
			.AluOP(ALUOpWire),
			.AluFunc(AluFuncWire));
	
	Registros BR(
			.RA1(InsWire[25:21]),
			.RA2(InsWire[20:16]),
			.Dir(Mux2Result),
			.en(RegWriteWire),
			.Dw(Mux1Result),
			.S1(S1Wire),
			.S2(S2Wire));
	
	MemIns MI(
			.Address(AddressWire),
			.Instruccion(InsWire));
	
	Mux2a1 Mux1(
			.D1(RamOut),
			.D2(AluResult),
			.SD(MemToRegWire),
			.Salida(Mux1Result));
	
	Mux2a15B M215B(
			.D1(InsWire[15:11]),
			.D2(InsWire[20:16]),
			.SD(RegDstWire),
			.Salida(Mux2Result));
			
	Mux2a1 Mux3(
			.D1(extendedWire),
			.D2(S2Wire),
			.SD(ALUSrcWire),
			.Salida(Mux3Result));
			
	Mux2a1 Mux4(
			.D1(AdderResult),
			.D2(AddressPlus4),
			.SD(BranchAndZF),
			.Salida(Mux4Result));
	
	Mux2a1 Mux5(
			.D1({AddressPlus4[31:28],ShiftLeftResult}),
			.D2(Mux4Result),
			.SD(JumpWire),
			.Salida(PCinWire));
	
	PC ProgramCounter(
			.PCNext(PCinWire),
			.Clk(Clk),
			.PCResult(AddressWire));
	
	Ram R1(
			.Dato(S2Wire),
			.Dir(AluResult),
			.Sel(MemToWriteWire),
			.Sel2(MemReadWire),
			.Salida(RamOut));
	
	SL2 ShiftLeft(
			.in(InsWire[25:0]),
			.out(ShiftLeftResult));
	
	SL32B ShiftLeft2(
			.in(extendedWire),
			.out(extendedShifted));
			
	SE SignExtend(
			.unextend(InsWire[15:0]),
			.extended(extendedWire));
	
	UnidadControl UC(
			.Opcode(InsWire[31:26]),
			.RegDst(RegDstWire),
			.Branch(BranchWire),
			.MemRead(MemReadWire),
			.MemToReg(MemToRegWire),
			.ALUOp(ALUOpWire),
			.MemToWrite(MemToWriteWire),
			.ALUSrc(ALUSrcWire),
			.RegWrite(RegWriteWire),
			.Jump(JumpWire));
	
	assign BranchAndZF = BranchWire & ZFwire;
	initial 
		begin
			
			Clk = 1'b0;
			forever #100
			Clk = ~Clk;
		end
endmodule
