
module ProgramCounterTest();

    reg clk;
    reg rst;
   
    wire [31:0] PC_in;
    
    integer i;
    
    
    ProgramCounter PrCo(clk, rst, PC_in, PC_in);
    

    
    initial begin
   

       clk = 0;
       rst = 0;
       
       rst = 1;
       #10
       rst = 0;
       for(i = 0; i <= 20; i = i + 1)
       begin
          #10
          clk = ~clk;
       end
    end
    
endmodule