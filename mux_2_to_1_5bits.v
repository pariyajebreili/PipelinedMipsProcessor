`timescale 1ns/1ns
module mux_2_to_1_5bits (Output1, Input0, Input1, Selector);
    input [4:0] Input0, Input1;
    input Selector;
    
    output [4:0] Output1;
    

    assign Output1 = 	(Selector == 1'b0) ? Input0 :
		                (Selector == 1'b1) ? Input1 : 5'bx;

endmodule

