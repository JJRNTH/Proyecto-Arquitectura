module Add4(
			input [31:0]Entrada,
			output reg [31:0]Sal);
		
		always@(*)
			begin
				Sal = Entrada + 3'd4;
			end
endmodule