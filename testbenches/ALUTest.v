`timescale 1ns/1ns
//`include "ALU.v"

module ALUTest();
    
    reg [31:0] Operand1;
    reg [31:0] Operand2;
    reg [1:0] ALUControl;

    wire [31:0] ALUResult;
    wire Zero;
    
    ALU alu(Operand1, Operand2, ALUControl, ALUResult, Zero);
    
    initial
    begin
      /*
       Operand1 = 32'b00000000000000000000000001010101; // 85
       Operand2 = 32'b00000000000000000000000001010101; // 85
       ALUControl = 4'b10;
       
       #20
       Operand1 = 32'b00000000000000000000000001010101; // 85
       Operand2 = 32'b00000000000000000000000001010101; // 85
       ALUControl = 4'b11;      
       */ 
        /*
       Operand1 = 32'b00000000000000000000000001010101; // 85
       Operand2 = 32'b00000000000000000100000010101010; // 16554
       ALUControl = 4'b00;
       
       #20
       // AND
       ALUControl = 4'b00;
       
       #20
       // OR
       ALUControl = 4'b01;
       
       #20
       // ADD
       ALUControl = 4'b10;
       
       #20
       // SUB
       ALUControl = 4'b11;

       #50       
       Operand1 = 32'b00000000000000000000000001010101; 
       Operand2 = 32'b00000000000000000000000001010101; 

       #20
       ALUControl = 4'b11;
       
       */
       
              
       Operand1 = 32'b00000000000000000000000000000000; 
       Operand2 = 32'b00000000000000000000000000000001; 
       ALUControl = 4'b11;
       
       #20;
       
    end

      initial begin

        $dumpfile("alutest.vcd");
        $dumpvars(0,ALUTest);  

      end
    
endmodule

