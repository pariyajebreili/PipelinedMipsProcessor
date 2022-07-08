`define AND 2'b00
`define OR  2'b01
`define ADD 2'b10
`define SUB 2'b11

`timescale 1ns/1ns

module ALU(Operand1, Operand2, ALUControl, ALUResult, Zero);
    
    input [31:0] Operand1;
    input [31:0] Operand2;
    input [1:0] ALUControl;
    
    output reg [31:0] ALUResult;
    output reg Zero;
    
    always @ (*)
    begin
      Zero = 0;
       case (ALUControl)
           `AND : ALUResult = (Operand1 & Operand2);
           `OR  : ALUResult = (Operand1 | Operand2);
           `ADD : ALUResult = Operand1 + Operand2;
           `SUB : 
              begin
                 ALUResult = Operand1 - Operand2;
                 Zero = (ALUResult == 0) ? 1'b1 : 1'b0; // 1:True 0:False  
              end
      endcase
    end    
    
endmodule
