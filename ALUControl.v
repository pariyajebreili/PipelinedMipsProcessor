module ALUControl(clk, ALUControl, ALUOp, funct);

	input clk;
	input [3:0] ALUOp;
	input [5:0] func;
	output [3:0] ALUControl;

	assign ALUControl = 	(ALUOp == 4'b0000) ? 4'b0000:
					(ALUOp == 4'b0001) ? 4'b0001:
					(ALUOp == 4'b0011) ? 4'b0010:
					(ALUOp == 4'b0100) ? 4'b0011:
					(ALUOp == 4'b0101) ? 4'b1000:
					(ALUOp == 4'b0010) ? 
					((func == 6'b100000) ? 4'b0000:
					(func == 6'b100010) ? 4'b0001:
					(func == 6'b100100) ? 4'b0010:
					(func == 6'b100101) ? 4'b0011:
					(func == 6'b100111) ? 4'b1001:
					(func == 6'b101010) ? 4'b1000:
					(func == 6'b000000) ? 4'b0100:
					(func == 6'b000010) ? 4'b0101 : 4'bxxxx): 4'bxxxx;

endmodule
