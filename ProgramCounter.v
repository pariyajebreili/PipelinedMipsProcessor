`timescale 1ns/1ns
module ProgramCounter(clk, rst, PcIn, new_pc, branch_zero_and,PcNext);

	input clk, rst, branch_zero_and;
	input [31:0] PcIn, new_pc;
	
	output reg [31:0] PcNext;
	
	always @(posedge clk) 
      begin
		if (rst == 1) 
		    PcNext = 0;
		else if (branch_zero_and) 
			PcNext = new_pc + 1;		    
		else 
		    PcNext = PcIn + 1; 

	end
endmodule


// module ProgramCounter(clk, rst, pc);

// 	input clk, rst;

//     inout [31:0] pc;
   
//     reg [31:0] PC_reg;
	
// 	always @(posedge clk or rst) begin
// 		if (rst == 1) 
// 		    PC_reg <= 0;
// 		else 
// 		    PC_reg <= pc + 1; 
// 	end


//     assign pc = PC_reg;
    
//    initial begin
//        $display("%b", pc);
//    end

    
// endmodule
