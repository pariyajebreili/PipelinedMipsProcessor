

module testbech();

      reg clk,rst;
      wire ALUSrc,Zero;
      wire [4:0] WriteReg;
      wire [1:0] ALUOperation;
      wire [31:0] Instruction, pc_in, ReadData1, ReadData2, WriteDataReg;
 
      integer i;
   
      Mips MIPS(clk, rst, pc_in ,Instruction, ReadData1, ReadData2,  WriteDataReg,
      WriteReg, Zero, branch, RegDst, RegWrite, MemToReg, ALUSrc, MemRead, MemWrite, ALUOperation);
      
 
    initial begin
   
       rst = 1;
       clk = 0;
       clk = 1;
       
       #50;
       rst = 0;

          
       
       for(i = 0; i <= 20; i = i + 1)
       begin
          
          clk = ~clk;
          #50;
       end
       
   end

endmodule