module Shift_L_2(
	input [31:0]dato,
	output reg[31:0] salida
);

always@(*)
	begin
		salida=dato << 2;
	end

endmodule
