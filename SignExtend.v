module SignExtend(Input1, Output1);
   
   input [15:0] Input1;
   
   output reg [31:0] Output1;
   
   always @(*)
   begin

       if(Input1[15] == 1'b1)
       begin
           Output1 = {16'b1111111111111111, Input1};
       end
       else
       begin
          Output1  = Input1; 
       end
         
   end
   
endmodule

