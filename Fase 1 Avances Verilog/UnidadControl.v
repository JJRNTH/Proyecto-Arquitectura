module UnidadControl(
	input [5:0]Opcode,
	output reg MemToReg,
	output reg RegWrite,
	output reg MemToWrite,
	output reg [2:0]ALUOp
	);
	
	always@*
		begin
			MemToReg = Opcode[0:0];
			RegWrite = Opcode[1:1];
			MemToWrite = Opcode[2:2];
			ALUOp = Opcode[5:3];
		end
endmodule
