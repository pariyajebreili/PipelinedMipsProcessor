// `timescale 1ns/1ns
// module PcAdder(PcNext, ShiftOut, AddAluOut);

// 	input [31:0] PcNext;
// 	input [31:0] ShiftOut;
	
// 	output reg [31:0] AddAluOut;

// 	always @(*) 
// 	begin
// 		AddAluOut <= PcNext + ShiftOut;
// 	end
      
// endmodule

`timescale 1ns/1ns
module Adder(In1, In2, AddAluOut);

	input [31:0] In1, In2;
	
	output reg [31:0] AddAluOut;

	always @(*) 
	begin
		AddAluOut <= In1 + In2;
	end
      
endmodule