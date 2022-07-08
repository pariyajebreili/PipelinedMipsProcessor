// `timescale 1ns/1ns
// module ProgramCounter(clk, rst, PcIn, new_pc, branch_zero_and,PcNext);

// 	input clk, rst, branch_zero_and;
// 	input [31:0] PcIn, new_pc;
	
// 	output reg [31:0] PcNext;
	
// 	always @(posedge clk) 
//       begin
// 		if (rst == 1) 
// 		    PcNext = 0;
// 		else if (branch_zero_and) 
// 			PcNext = new_pc + 1;		    
// 		else 
// 		    PcNext = PcIn + 1; 

// 	end
// endmodule

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