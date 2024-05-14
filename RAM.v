module Ram(input [31:0]Dato,
		input[5:0]Dir,
		input Sel,
		output reg[31:0]Salida) ;
		reg [31:0] Dato1[0:31];
	
		always @*
			begin
				if(Sel)
					begin
						Dato1[Dir] = Dato;
						Salida = Dato1[Dir];
					end
			end
endmodule 
