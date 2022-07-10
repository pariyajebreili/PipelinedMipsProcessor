`timescale 1ns/1ns

module ProgramCounter(clk, rst, PcNext, PcIn);

	input clk, rst;
	input [31:0] PcNext;
	output reg [31:0] PcIn;
	
	always @(posedge clk) 
      begin
		if (rst == 1) 
		    PcIn = 0;		    
		else 
		    PcIn = PcNext;

	end
endmodule