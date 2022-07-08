`timescale 1ns/1ns
module PcAdder(PcNext, ShiftOut, AddAluOut);

	input [31:0] PcNext;
	input [31:0] ShiftOut;
	
	output reg [31:0] AddAluOut;

	always @(*) 
	begin
		AddAluOut <= PcNext + ShiftOut;
	end
      
endmodule