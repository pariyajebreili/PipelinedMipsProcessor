module ALU32Bit(data1, data2, ALUControl, shiftAmount, overFlow, zero, ALUResult, reset);

input wire reset;
input wire signed [31:0] data1,data2;
input wire [3:0] ALUControl;
input wire [4:0] shiftAmount;
output reg overFlow, zero;
output reg signed [31:0] ALUResult;

wire [31:0] neg_data2;
assign neg_data2 = -data2;

parameter ADD = 4'b0000;
parameter SUB = 4'b0001;
parameter AND = 4'b0010;
parameter OR = 4'b0011;


always @(posedge reset) zero <= 1'b0;

always @(ALUControl, data1, data2)
begin

if(data1 == data2)
zero <= 1'b1;
else
zero <= 1'b0;

case(ALUControl)

ADD: 
	begin	
	ALUResult <= data1 + data2;
	if(data1[31] == data2[31] && ALUResult[31] == ~data1[31])
	overFlow <= 1'b1;
	else
	overFlow <= 1'b0;
	end

SUB:
	begin
	ALUResult <= data1 + neg_data2;
	if(data1[31] == neg_data2[31] && ALUResult[31] == ~data1[31])
	overFlow <= 1'b1;
	else
	overFlow <= 1'b0;
	end
	
AND:
	ALUResult <= data1 & data2;

OR:
	ALUResult <= data1 | data2;



endcase
end

endmodule

// `define AND 2'b00
// `define OR  2'b01
// `define ADD 2'b10
// `define SUB 2'b11

// `timescale 1ns/1ns

// module ALU(Operand1, Operand2, ALUControl, ALUResult, Zero);
    
//     input [31:0] Operand1;
//     input [31:0] Operand2;
//     input [1:0] ALUControl;
    
//     output reg [31:0] ALUResult;
//     output reg Zero;
    
//     always @ (*)
//     begin
//       Zero = 0;
//        case (ALUControl)
//            `AND : ALUResult = (Operand1 & Operand2);
//            `OR  : ALUResult = (Operand1 | Operand2);
//            `ADD : ALUResult = Operand1 + Operand2;
//            `SUB : 
//               begin
//                  ALUResult = Operand1 - Operand2;
//                  Zero = (ALUResult == 0) ? 1'b1 : 1'b0; // 1:True 0:False  
//               end
//       endcase
//     end    
    
// endmodule
