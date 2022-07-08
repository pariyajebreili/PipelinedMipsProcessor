`timescale 1ns/1ns
module RegisterFile(clk, rst, ReadRegister1, ReadRegister2, WriteData, WriteReg,RegWriteActive, ReadData1, ReadData2);

    // WriteData: the data to write
    // WriteReg: number of register to write
    // RegWriteActive: control signal for writing register => 1: write - 0: not write
    input rst, clk;
    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [31:0] WriteData;
    input [4:0] WriteReg;
    input RegWriteActive;

    output [31:0] ReadData1, ReadData2;


    integer i;


    reg [31:0] RegFile [0:31];


     assign ReadData1 = (ReadRegister1 == 5'b00000)? 32'h00000000: RegFile[ReadRegister1];
     assign ReadData2 = (ReadRegister2 == 5'b00000)? 32'h00000000: RegFile[ReadRegister2];


    always @ (posedge clk)
    begin
        if (rst)
			for (i = 1; i < 32; i = i + 1)
				RegFile[i] <= i;
        else if (RegWriteActive)
            RegFile[WriteReg] <= WriteData;

    end





endmodule

