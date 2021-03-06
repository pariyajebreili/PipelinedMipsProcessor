`define ADD  4'b0000;
`define SUB  4'b0001;
`define AND  4'b0010;
`define OR   4'b0011;


module ALU32Bit(Operand1, Operand2, ALUControl, shiftAmount, zero, ALUResult, reset);

	input wire reset;
	input wire signed [31:0] Operand1,Operand2;
	input wire [3:0] ALUControl;
	input wire [4:0] shiftAmount;
	output reg  zero;
	output reg signed [31:0] ALUResult;


	always @(posedge reset) zero <= 1'b0;

	always @(ALUControl, Operand1, Operand2)
	begin

		if(Operand1 == Operand2)
			zero <= 1'b1;
		else
			zero <= 1'b0;

		case(ALUControl)

			0000: begin	
				ALUResult <= Operand1 + Operand2;
				end

			0001:
				begin
				ALUResult <= Operand1 - Operand2;
				end
				
			0010:
				ALUResult <= Operand1 & Operand2;

			0011:
				ALUResult <= Operand1 | Operand2;

		endcase
	end

endmodule
