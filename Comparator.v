module Comparator(inOperand1 ,inOperand2 ,equalFlag);

      input [31:0]  inOperand1;
      input [31:0]  inOperand2;
      output equalFlag;

      assign equalFlag = (inOperand1 == inOperand2) ? 1'b1 : 1'b0;

endmodule
