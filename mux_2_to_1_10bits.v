module mux_2_to_1_10bits(Output, Input0, Input1, Selector);

	input [9:0] Input0, Input1;
	input Selector;
	output [9:0] Output;

	assign Output = (Selector == 1'b0) ? Input0 :
			(Selector == 1'b1) ? Input1 : 10'bx;

endmodule
