module ALU(input [31:0]OP1, 
		input [31:0]OP2, 
		input [3:0]Sel,
		output reg [31:0]Resultado,
		output reg ZF);
		
always@(OP1,OP2,Sel)
	begin
		//AND
		if(Sel==0)
			begin
				Resultado = OP1 & OP2;
			end
		//OR
		if(Sel==1)
			begin
				Resultado = OP1 | OP2;
			end
		//SUMA
		if(Sel==2)
			begin
				Resultado = OP1 + OP2;
			end
		//RESTA
		if(Sel==6)
			begin
				Resultado = OP1 - OP2;
			end
		//SET ON LESS THAN
		if(Sel==7)
			begin
				if(OP1>OP2) begin
					Resultado = 1;
				end
				else begin
					Resultado = 0;
				end
			end
		//NOR
		if(Sel==12)
			begin
				Resultado = ~(OP1 | OP2);
			end
	end
	
	//Zero Flag
	always @(Resultado) 
		begin
			if (Resultado == 0) 
				begin
					ZF = 1;
				end 
			else 
				begin
					ZF = 0;
				end
		end
endmodule
