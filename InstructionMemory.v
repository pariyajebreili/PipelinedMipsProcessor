
// `timescale 1ns/1ns
// module InstructionMemory(clk, Address, Instruction);

// 	input [31:0] Address;
//     input clk;

// 	output reg [31:0] Instruction;
	
// 	reg [31:0] IMEM [0:127];

// 	always @(Address) Instruction = IMEM[Address];


//     initial
//     begin

// 	  IMEM[0] = 32'h01095020; //add $10, $8, $9                 //add $t2 $t0 $t1
//       IMEM[1] = 32'hAC0A0000; //sw $10, 0($0)                   //sw $t2 0($zero) //Hazard here
//       IMEM[2] = 32'h01495822; //sub $11, $10, $9                //sub $t3 $t2 $t1 //Hazard here
//       IMEM[3] = 32'h1168FFFC; //beq $11, $8, -4                 //beq $t3 $t0 -4  //Hazard here
//       IMEM[4] = 32'hAC0A0000; //sw $10, 0(0)                    //sw $t2 0($zero)


//       // lw $9, 3($3 = 3) ---> load memory block with address 6 and store it in $10
//     //   IMEM[0] = 32'b100011_00011_01001_0000000000000011;
//       // add $5, $9, $5 ---> $5 = 5 + 5 = 10
//     //   IMEM[1]  = 32'b000000_00101_01001_00101_00101_100000;








//     end
      
// endmodule
module InstructionMemory(clk,pc,readdata);

input clk;
input  [31:0] pc;
reg [31:0] IMEM [0:1023];
output reg [31:0] readdata;

initial //for testing
	begin
		// $readmemh("code.txt",IMEM);
        IMEM[0] = 32'h01095020; //add $10, $8, $9                 //add $t2 $t0 $t1
        IMEM[1] = 32'hAC0A0000; //sw $10, 0($0)                   //sw $t2 0($zero) //Hazard here
        IMEM[2] = 32'h01495822; //sub $11, $10, $9                //sub $t3 $t2 $t1 //Hazard here
        IMEM[3] = 32'h1168FFFC; //beq $11, $8, -4                 //beq $t3 $t0 -4  //Hazard here
        IMEM[4] = 32'hAC0A0000; //sw $10, 0(0)                    //sw $t2 0($zero)

    //   // lw $10, 0($0) ---> load memory block with address 6 and store it in $10
    //   IMEM[5]  = 32'b100011_00000_01010_0000000000000000;
    //   // add $12, $10, $1
    //   IMEM[6]  = 32'b000000_00001_01010_01100_00000_100000;


	end


always @ (pc)
	
	begin	 
	readdata <= IMEM[pc>>2];
	end			
		
endmodule	
