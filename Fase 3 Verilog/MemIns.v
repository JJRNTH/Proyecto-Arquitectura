module MemIns(
		input[31:0]Address,
		output [31:0]Instruccion);
		reg [7:0] mem[0:254];
	
	initial
		begin
			$readmemb("instrucciones.txt",mem);
		end
	
	assign Instruccion[31:24] = mem[Address];
	assign Instruccion[23:16] = mem[Address+1'd1];
	assign Instruccion[15:8] = mem[Address+2'd2];
	assign Instruccion[7:0] = mem[Address+2'd3];

endmodule 