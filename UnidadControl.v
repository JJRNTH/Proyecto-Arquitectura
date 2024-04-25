module UnidadControl(
	input [5:0]Opcode,
	output reg MemToReg,
	output reg RegWrite,
	output reg MemToWrite,
	output reg [2:0]ALUOp
	);

always @(*)
begin
	case(Opcode)
	6'b000000: begin // ADD
		MemToReg = 1'b0;
		MemToWrite = 1'b0;
		ALUOp = 3'b000; // Suma
	end
	6'b000001: begin // SUB
		MemToReg = 1'b0;
		MemToWrite = 1'b0;
		ALUOp = 3'b000; // Resta
	end
	6'b000010: begin // AND
		MemToReg = 1'b0;
		MemToWrite = 1'b0;
		ALUOp = 3'b000; // And
	end
	6'b000011: begin // OR
		MemToReg = 1'b0;
		MemToWrite = 1'b0;
		ALUOp = 3'b000; // Or
	end
	6'b000100: begin // SLT
		MemToReg = 1'b0;
		MemToWrite = 1'b0;
		ALUOp = 3'b000; // SLT
	end
	endcase
end
endmodule