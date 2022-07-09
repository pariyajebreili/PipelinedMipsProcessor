module IFIDReg(clk ,PCPlusOne ,instrIn ,instrOut ,hold,PCPlusOneOut,IF_flush);

  input wire [31:0] instrIn,PCPlusOne;
  input clk ,hold,IF_flush;
  output reg [31:0] instrOut, PCPlusOneOut;

  always @(posedge clk)
    begin
      
      if (hold==1'b0) 
        
        begin
          
      PCPlusOneOut<=PCPlusOne;
          
      instrOut <= instrIn;
          
      end
      else if (IF_flush==1'b1)
        begin
          PCPlusOneOut<=PCPlusOne; 
          instrOut<=32'b0;
        end
      
      
    end
  
endmodule
