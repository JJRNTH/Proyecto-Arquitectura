module Adder(
			input [31:0]E1,
			input [31:0]E2,
			output reg [31:0]Sal);
		
		always@(*)
			begin
				Sal = E1 + E2;
			end
endmodule
