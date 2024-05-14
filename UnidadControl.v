module UnidadControl(
	input [5:0]Opcode,
	output reg RegDst,
	output reg Branch,
	output reg MemRead,
	output reg MemToReg,
	output reg [2:0]ALUOp,
	output reg MemToWrite,
	output reg ALUSrc,
	output reg RegWrite
	);

	always@*
		begin
			MemToReg = Opcode[0:0];
			RegWrite = Opcode[1:1];
			MemToWrite = Opcode[2:2];
			ALUOp = Opcode[5:3];
		end
endmodule
