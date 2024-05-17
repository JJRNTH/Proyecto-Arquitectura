module PC(
			input [31:0]PCNext,  
			reg Clk,
			output reg [31:0]PCResult);

	initial 
		begin
			PCResult = 32'd0;
		end

    always @(posedge Clk)
		begin
			PCResult = PCNext;
		end

endmodule
