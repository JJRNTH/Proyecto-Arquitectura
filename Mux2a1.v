module Mux2a1(
				input [31:0]D1,
				input [31:0]D2,
				input SD,
				output reg [31:0]Salida);
	always@*
		begin
			case(SD)
				1'b1: Salida = D1;
				1'b0: Salida = D2;
				default: Salida = D1;
			endcase
		end
endmodule