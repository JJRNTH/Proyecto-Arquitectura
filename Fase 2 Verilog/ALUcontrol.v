module AluControl(
					input [5:0]Func,
					input [2:0]AluOP,
					output reg [3:0]AluFunc);
	
	always@*
		begin
			case(Func)
				6'b100100: AluFunc = 4'b0000;
				6'b100101: AluFunc = 4'b0001;
				6'b100000: AluFunc = 4'b0010;
				6'b100010: AluFunc = 4'b0110;
				6'b101010: AluFunc = 4'b0111;
				default: AluFunc = 4'b0000;
			endcase
		end
	
endmodule
