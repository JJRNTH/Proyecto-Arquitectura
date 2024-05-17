module MemIns(input [7:0]Dato,
		input[31:0]Address,
		output reg[7:0]Instruccion);
		reg [7:0] MemIns[0:254];
	
	initial
		begin
			$readmemb("instrucciones.txt",Dato1);
		end
	
		always @*
			begin
				MemIns[Address] = Dato;
				Instruccion = MemIns[Address];
			end
endmodule 