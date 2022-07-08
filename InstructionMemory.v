`timescale 1ns/1ns
module IntructionMemory(Address, Instruction);

	input [31:0] Address;

	output reg [31:0] Instruction;
	
	reg [31:0] IMEM [0:127];

	always @(Address) Instruction = IMEM[Address];


    initial
    begin
      // sw $5, 0($6 = 6)  ---> write $5 which value is 5 in memory block with address 6
      IMEM[0] = 32'b101011_00110_00101_0000000000000000;

      // lw $10, 3($3 = 3) ---> load memory block with address 6 and store it in $10
      IMEM[1] = 32'b100011_00011_01010_0000000000000011;

      // add $5, $5, $5 ---> $5 = 5 + 5 = 10
      IMEM[2]  = 32'b000000_00101_00101_00101_00000_100000;
      
      //sub $11, $10, $6; ---> $11 = 5 - 6 = -1
      IMEM[3] = 32'b000000_01010_00110_01011_00000_100010;
      
      // add $4, $3, $3; ---> $4 = 3 + 3 = 6
      IMEM[4] = 32'b000000_00011_00011_00100_00000_100000;

      // sub $3, $1, $2 ---> $3 = 1 - 2 = -1
      IMEM[5] = 32'b000000_00001_00010_00011_00000_100010;
      
      // add $10, $1, $10; ---> $10 = 1 + 5 = 6
      IMEM[6] = 32'b000000_00001_01010_01010_00000_100000; 

      //  beq $20, $20, 7 ---> jump to memory block with address 15
      IMEM[7] = 32'b000100_10100_10100_0000000000000111;

      // add $4, $3, $0;  ---> won't be executed because of jump
      IMEM[8] = 32'b00000000000000110010000000100000; 

      // sub $10, $0, $10; ---> $10 = 0 - 6 = -6
      IMEM[15]  = 32'b00000000000010100101000000100010;

      //  add $7, $5, $5 ---> $7 = 10 + 10 = 10
      IMEM[16] = 32'b000000_00101_00101_00111_00000_100000;

      //  beq $10, $15, 3 -- won't jump!
      IMEM[17] = 32'b000100_01010_01111_0000000000000011;

    end
      
endmodule
