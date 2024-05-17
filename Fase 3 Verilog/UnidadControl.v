module UnidadControl(
	input [5:0]Opcode,
	output reg RegDst,
	output reg Branch,
	output reg MemRead,
	output reg MemToReg,
	output reg [1:0]ALUOp,
	output reg MemToWrite,
	output reg ALUSrc,
	output reg RegWrite,
	output reg Jump
	);

	always@(*)
		begin
			case(Opcode)
				6'b000000:
				begin
					RegDst = 1'b1;
					Branch = 1'b0;
					MemRead = 1'b0;
					MemToReg = 1'b0;
					ALUOp = 2'b10;
					MemToWrite = 1'b0;
					ALUSrc = 1'b0;
					RegWrite = 1'b1;
					Jump = 1'b0;
				end
				6'b100011:
				begin
					RegDst = 1'b0;
					Branch = 1'b0;
					MemRead = 1'b1;
					MemToReg = 1'b1;
					ALUOp = 2'b00;
					MemToWrite = 1'b0;
					ALUSrc = 1'b1;
					RegWrite = 1'b1;
					Jump = 1'b0;
				end
				6'b101011:
				begin
					RegDst = 1'bx;
					Branch = 1'b0;
					MemRead = 1'b0;
					MemToReg = 1'bx;
					ALUOp = 2'b00;
					MemToWrite = 1'b1;
					ALUSrc = 1'b1;
					RegWrite = 1'b0;
					Jump = 1'b0;
				end
				6'b000100:
				begin
					RegDst = 1'bx;
					Branch = 1'b1;
					MemRead = 1'b0;
					MemToReg = 1'bx;
					ALUOp = 2'b01;
					MemToWrite = 1'b0;
					ALUSrc = 1'b0;
					RegWrite = 1'b0;
					Jump = 1'b0;
				end
				6'b000010:
				begin
					RegDst = 1'bx;
					Branch = 1'bx;
					MemRead = 1'bx;
					MemToReg = 1'bx;
					ALUOp = 2'bx;
					MemToWrite = 1'bx;
					ALUSrc = 1'bx;
					RegWrite = 1'bx;
					Jump = 1'b1;
				end
			endcase
		end
endmodule
