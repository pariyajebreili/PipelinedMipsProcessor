`define FUNC_ADD 6'b100000
`define FUNC_SUB 6'b100010
`define FUNC_AND 6'b100100
`define FUNC_OR  6'b100101

`define LW     6'b100011
`define SW     6'b101011
`define BEQ    6'b000100
`define RTYPE  6'b000000

`timescale 1ns/1ns

module Controller(func, opcode,RegDst,RegWrite, ALUSrc,MemToReg, MemRead, MemWrite,branch,ALUOperation);
	
	input [5:0] opcode, func;
	output reg RegDst,RegWrite, ALUSrc,MemToReg, MemRead, MemWrite,branch;
	output reg [1:0] ALUOperation;
 
				  
	
	always @(*) begin

		RegDst 		= 0;
		ALUSrc 		= 0;
		MemToReg	= 0;
		RegWrite	= 0;
		MemRead		= 0;
		MemWrite	= 0;
		branch		= 0;

		//select oprand
		case(opcode)	
			`LW: begin
				ALUSrc 	 		= 1;
				RegWrite 		= 1;
				MemRead	 		= 1;
				MemToReg 		= 1;
				ALUOperation	= 2'b10;
			end
			`SW: begin
				RegDst     		= 1'bx;
				ALUSrc 	   		= 1;
				MemToReg   		= 1'bx;
				MemWrite   		= 1;
				ALUOperation	= 2'b10;
			end
			`BEQ: begin
				RegDst    		= 1'bx;
				MemToReg 		= 1'bx;
				branch			= 1;
				ALUOperation	= 2'b11;
			end
			`RTYPE: begin
				RegDst 		= 1;
				RegWrite	= 1;
				case(func)
						`FUNC_ADD : ALUOperation = 2'b10;
						`FUNC_SUB : ALUOperation = 2'b11;
						`FUNC_AND : ALUOperation = 2'b00;
						`FUNC_OR  :  ALUOperation = 2'b01;
				endcase
			end
		endcase
	end
endmodule