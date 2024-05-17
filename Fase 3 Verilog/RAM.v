module Ram(input [31:0]Dato,
		input[5:0]Dir,
		input Sel,
		input Sel2,
		output reg[31:0]Salida) ;
		reg [31:0] Dato1[0:31];
	
	initial
		begin
			$readmemb("mem.txt",Dato1);
		end
	
		always @(*)
			begin
				if(Sel)
					begin
						Dato1[Dir] = Dato;
					end
				if(Sel2)
					begin
						Salida = Dato1[Dir];
					end
			end
endmodule 
