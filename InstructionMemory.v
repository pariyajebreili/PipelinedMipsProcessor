


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
        // IMEM[0] = 32'h01095020; //add $10, $8, $9          2886336512                           //add $t2 $t0 $t1
        // IMEM[1] = 32'hAC0A0000; //sw $10, 0($0)            17387552                          //sw $t2 0($zero) //Hazard here
        // IMEM[2] = 32'h01495822; //sub $11, $10, $9         21583906                             //sub $t3 $t2 $t1 //Hazard here
        // IMEM[3] = 32'h8C6A0003;  // lw $10, 0($0)
        // IMEM[4] = 32'h14A5020; // add $12, $10, $1
        // IMEM[5] = 32'h1168FFFC; //beq $11, $8, -4          292093948                             //beq $t3 $t0 -4  //Hazard here
        // IMEM[6] = 32'hAC0A0000; //sw $10, 0(0)                                    //sw $t2 0($zero)


        //add $10, $8, $9
        IMEM[0] = 32'b000000_01000_01001_01010_00000_100000;
        //sw $10, 0($0) 
        IMEM[1] = 32'b101011_00000_01010_0000000000000000;
        //sub $11, $10, $9 
        IMEM[2] = 32'b000000_01010_01001_01011_00000_100010;
        // lw $10, 3($3)
        IMEM[3] = 32'b100011_00011_01010_0000000000000011;
        // add $15, $11, $10
        IMEM[4] = 32'b000000_01011_01010_01111_00000_100000;
        //beq $11, $8, -4 
        IMEM[5] = 32'b000100_01011_01000_1111111111111100;
        //sw $10, 0(0)
        IMEM[6] = 32'b101011_00000_01010_0000000000000000;


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
