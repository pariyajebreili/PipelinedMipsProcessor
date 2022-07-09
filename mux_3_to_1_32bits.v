module mux_3_to_1_32bits(Output, Input0, Input1, Input2, Selector);

input [31:0] Input0, Input1, Input2;
input [1:0] Selector;
output [31:0]Output;

assign out = (Selector == 2'b00) ? Input0 :
		 (Selector == 2'b01) ? Input1 : 
		 (Selector == 2'b10) ? Input2 : 32'bx;

endmodule
