module IDEXReg (clk,RegWrite, MemtoReg, MemWrite, MemRead,ALUSrc, ALUOp, RegDst, PCplusOne ,ReadData1_in ,ReadData2_in
		,RegisterAddresses, SignExtendResult_in, PCplusOneout ,ReadData1_out ,ReadData2_out ,SignExtendResult_out ,rsOut ,rtOut ,rdOut, RegWriteOut
		,MemtoRegOut,MemWriteOut, MemReadOut,ALUSrcOut, ALUOpOut, RegDstOut);
  
  input wire RegWrite, MemtoReg;
  input wire MemWrite, MemRead; 
  input wire ALUSrc, RegDst;
  input wire [1:0] ALUOp;
  output reg RegWriteOut, MemtoRegOut;
  output reg MemWriteOut, MemReadOut;
  output reg ALUSrcOut, RegDstOut;
  output reg [1:0] ALUOpOut;

  input wire [31:0] PCplusOne ,ReadData1_in ,ReadData2_in ,SignExtendResult_in;
  input wire [14:0] RegisterAddresses;
  input wire clk;

  output reg [31:0] PCplusOneout ,ReadData1_out ,ReadData2_out ,SignExtendResult_out;
  output reg [4:0] rsOut ,rtOut ,rdOut;

  
  always @(posedge clk)
  begin
      PCplusOneout <= PCplusOne;
      ReadData1_out <= ReadData1_in;
      ReadData2_out <= ReadData2_in;
      SignExtendResult_out <= SignExtendResult_in;
      rsOut <= RegisterAddresses[14:10];
      rtOut <= RegisterAddresses[9:5];
      rdOut <= RegisterAddresses[4:0];
      RegWriteOut <= RegWrite;
      MemtoRegOut <= MemtoReg;
      MemWriteOut <= MemWrite;
      MemReadOut <= MemRead;
      ALUSrcOut <= ALUSrc;
      ALUOpOut <= ALUOp;
      RegDstOut <= RegDst;
  end
  
endmodule
