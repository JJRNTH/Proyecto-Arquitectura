module ALUControl(
  	input [5:0] Funcs,	
	input [2:0] UC_coso,
	output [3:0] ALU_cosos
	); 


reg [2:0]ALU_coso;
reg [5:0]Func;

always @(*)
case (Funcs)
	3'b000: //Si la UC dijo que es R
	begin 
	//determina la operaciÃ³n de la ALU
        case (UC_coso)
            6'b100000: ALU_coso = 4'b0010; // ADD
            6'b100010: ALU_coso = 4'b0110; // SUB
            6'b100100: ALU_coso = 4'b0000; // AND
            6'b100101: ALU_coso = 4'b0001; // OR
            6'b101010: ALU_coso = 4'b0111; // SLT
            default: ALU_coso = 4'b0010; // ADD por default
        endcase
    end
    default: ALU_coso = 3'b000; // Sino es R, no hac nada
endcase

endmodule
