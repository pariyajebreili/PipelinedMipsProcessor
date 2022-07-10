module Adder (output1 ,input1, input2);

      input wire signed [31:0] input1, input2;
      output wire [31:0] output1  ;

      assign output1   = input1 + input2;

endmodule
