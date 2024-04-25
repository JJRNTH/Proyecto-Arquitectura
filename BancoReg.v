module Registros(
    input [4:0] RA1, 
	input [4:0] RA2, 
    input [4:0] Dir,    
    input en,      
    input [31:0] Dw,    
    output reg [31:0] S1, 
    output reg [31:0] S2);

reg [31:0] regs [0:31]; 

always @(*) 
	begin
		if (en) 
			begin
				regs[Dir] = Dw;
			end
		S1 = regs[RA1]; 
		S2 = regs[RA2];  
	end

endmodule