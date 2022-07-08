`timescale 1ns/1ns
//`include "PcAdder.v"

module PcAdderTest();
      reg [31:0] PcNext;
      reg [31:0] ShiftOut;
	 
      wire [31:0] AddAluOut;

      PcAdder PcAdder_inst(
            .PcNext(PcNext),
            .ShiftOut(ShiftOut),
            .AddAluOut(AddAluOut)
      );    




      initial 
      begin 
            PcNext = 32'h0000_0001;
            ShiftOut = 32'h0000_0110;
            #10;

      end

      initial begin

        $dumpfile("PcAdderTest.vcd");
        $dumpvars(0,PcAdderTest);  

      end

endmodule