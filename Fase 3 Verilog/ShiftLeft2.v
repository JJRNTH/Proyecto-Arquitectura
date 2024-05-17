module SL2(
			input [25:0]in,
			output reg [27:0]out);
		
		always@(*)
			begin
				out = in << 2;
			end
endmodule	