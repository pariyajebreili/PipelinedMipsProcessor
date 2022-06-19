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

      // lw $10, 3($3 = 3) 
      IMEM[1] = 32'b100011_00011_01010_0000000000000011;

      // add $5, $5, $5
      IMEM[2]  = 32'b000000_00101_00101_00101_00000_100000;
      
      //sub $11, $10, $6;
      IMEM[3] = 32'b000000_01010_00110_01011_00000_100010;
      
      // add $4, $3, $3; 
      IMEM[4] = 32'b000000_00011_00011_00100_00000_100000;

      // sub $3, $2, $1
      IMEM[5] = 32'b000000_00001_00010_00011_00000_100010;
      
      // bug: add $10, $1, $10;
      IMEM[6] = 32'b000000_00001_01010_01010_00000_100000; 

      //  beq $20, $20, 7
      IMEM[7] = 32'b000100_10100_10100_0000000000000111;

      // add $4, $3, $0;
      IMEM[8] = 32'b00000000000000110010000000100000; 

      // sub $10, $0, $10; // rs is zero
      IMEM[13]  = 32'b00000000000010100101000000100010;
      
      
        
        /* BUGS IN COMMANDS USING SAME REGISTERS IN R-TYPES!!!!!!! */
      //    rt    rs
      // sw $5, 0($6 = 6)  ---> write $5 which value is 5 in memory block with address 6
      //IMEM[0] = 32'b101011_00110_00101_0000000000000000;
      //    rt    rs 
      // lw $23, 0($6 = 6) ---> load memory block with address 6 into $23 (update $23 value with value 5)
      //IMEM[1] = 32'b100011_00110_10111_0000000000000000;
      
      //    rt     rs
      // sw $12, 5($2 = 2)     ---> write $12 which value is 12 in memory with address 7 = 5 + 2
      //IMEM[2] = 32'b101011_00010_01100_0000000000000101;
      
      // lw $10, 5($2 = 2)     ---> load memory block with address 7 into $10 (update $10 value with value 12)
      //IMEM[3] = 32'b100011_00010_01010_0000000000000101;
      
      // add $23, $0, $23
      // IMEM[4] = 32'b000000_00000_10111_10111_00000_100000;

      //sub $11, $10, $6;
      //IMEM[5] = 32'b000000_01010_00110_01011_00000_100010;
      
      // sub $3, $1, $2
      //IMEM[6] = 32'b000000_00001_00010_00011_00000_100010;


      
      // add $23, $0, $23
      // IMEM[2] = 32'b000000_00000_10111_10111_00000_100000;

      //sub $11, $10, $6;
      // IMEM[4] = 32'b000000_01010_00110_01011_00000_100010;

      // sub $3, $1, $2
      //IMEM[1] = 32'b000000_00001_00010_00011_00000_100010;

      // // add $4, $3, $3;
      // IMEM[5] = 32'b000000_00011_00011_00100_00000_100000;

      //  beq $21, $20, 3
      //IMEM[3] = 32'b000100_10101_10100_0000000000000011;

      // add $4, $3, $0;
      //IMEM[4] = 32'b000000_00000_00011_00100_00000_100000;
  
      // add $10, $0, $10;
      //IMEM[5] = 32'b000000_00000_01010_01010_00000_100000;

      //  add $7, $5, $5
      //IMEM[6] = 32'b000000_00101_00101_00111_00000_100000;

      // add $7, $0, $7
      //IMEM[7] = 32'b000000_00000_00111_00111_00000_100000;
      
      // bug: add $10, $1, $10;
      //IMEM[8] = 32'b000000_00001_01010_01010_00000_100000;      

      // maybe bug add $7, $7, $7
      // IMEM[7] = 32'b000000_00111_00111_00111_00000_100000;

      // bug? sub $10, $0, $10



                
        // not working - add $10, $10, $10;
        //   IMEM[0]  = 32'b00000001010010100101000000100000;
        
        // not working - add $10, $10, $0; // rt is zero
        //  IMEM[1]  = 32'b00000001010000000101000000100000;
        
        // not working - add $10, $0, $10; // rs is zero
        // IMEM[2]  = 32'b00000000000010100101000000100000;
        
        // not working - add $10, $1, $10; // rs is 1
        // IMEM[3]  = 32'b00000000001010100101000000100000;        
        

        
          // add $3, $2, $1
           //IMEM[0]  = 32'b00000000001000100001100000100000;
          
          // sub $10, $5, $9    
           //IMEM[1]  = 32'b00000001001001010101000000100010;

         // add $10, $10, $0;
           //IMEM[2]  = 32'b00000001010000000101000000100000;

        // add $20, $20, $0;
           //IMEM[3]  = 32'b00000010100000001010000000100000;

        //   add $3, $3, $0;
           //IMEM[0]  = 32'b00000000000000110001100000100000;

        // add $20, $5, $6
        //  IMEM[0] = 32'b00000000110001011010000000100000;

        // sub $21, $3, $4
         //IMEM[0] = 32'b00000000011001001010100000100010;

        // sub $3, $2, $1
        //  IMEM[1]  = 32'b00000000001000100001100000100010;
         
         // not working - add $10, $10, $0; // rt is zero
         //IMEM[1]  = 32'b00000001010010100101000000100000;

         //add $4, $2, $1
          //IMEM[3]  = 32'b00000000001000100010000000100000;
         

         
        //  add $7, $3, $3
          //IMEM[4]  = 32'b00000000101001010011100000100000; // this will work because it's not $7 in rs and rt

         // add $4, $3, $3;
        //   IMEM[2] = 32'b00000000011000110010000000100000;

        // add $4, $3, $0;
        //  IMEM[3] = 32'b00000000000000110010000000100000; // working fine

        // **************************** BUGS ARE IN INSTRUCTION WHICH HAVE SAME $rd and $rs or $rt like add $4, $4, $2....

        // lw $5, 3($1 = 4)
       // IMEM[7] = 32'b10001100001001010000000000000011;
        
        //add $5 = 8, $5 = 4, $1 = 4
        //IMEM[1] = 32'b00000000101000010010100000100000;
        //IMEM[2] = 32'b00000000101000010010100000100000;
    end
      
endmodule