module multiplexor(
	input[31:0]Entrada1,
	input[31:0]Entrada2,
	input seleccionador,
	output reg[3:0]salida
	);

always @(Entrada1 or Entrada2 or seleccionador)
begin
	case(seleccionador)
	2'b00 : salida = Entrada1;
	2'b01 : salida = Entrada2;
	endcase
end

endmodule

-------------
module MUX_TB();

reg Entrada_1;
reg Entrada_2;
reg seleksionador;

wire zalida;

multiplexor MEX(
	.Entrada1(Entrada_1),
	.Entrada2(Entrada_2),
	.seleccionador(seleksionador),
	.salida(zalida)
	);

initial
begin

	Entrada_1 = 32'd1;
	Entrada_2 = 32'd2;
	seleksionador = 0;
	#100	
	$stop;
end

endmodule	