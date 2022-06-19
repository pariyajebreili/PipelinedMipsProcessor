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

        //ReadData1 = RegFile[ReadRegister1];
        //ReadData2 = RegFile[ReadRegister2];
    end



    // initial begin
    //     RegFile[0] = 32'b00000000000000000000000000000000; // 0
    //     RegFile[1] = 32'b00000000000000000000000000000100; // 4
    //     RegFile[2] = 32'b00000000000100000000000000000100; // 1048580
    //     RegFile[3] = 32'b00000000000100000000000000000101; // 1048581
    //     RegFile[4] = 32'b00000000000100000000000000010100; // 1048596
    //     RegFile[5] = 32'b00000000000000000000010000010100; // 1044
    //     RegFile[6] = 32'b00000000000100000100000000010100; // 1064980
    //     RegFile[7] = 32'b00001000000100000000000000010100; // 135266324

    //     for(i = 8; i <= 31; i = i + 1)
    //        RegFile[i] = 32'b0000000000000000000000000000000;
    //     // RegFile[8] =  32'h00000000;
    //     // RegFile[9] =  32'h00000000;
    //     // RegFile[10] = 32'h00000000;
    //     // RegFile[11] = 32'h00000000;
    //     // RegFile[12] = 32'h00000000;
    //     // RegFile[13] = 32'h00000000;
    //     // RegFile[14] = 32'h00000000;
    //     // RegFile[15] = 32'h00000000;
    //     // RegFile[16] = 32'h00000000;
    //     // RegFile[17] = 32'h00000000;
    //     // RegFile[18] = 32'h00000000;
    //     // RegFile[19] = 32'h00000000;
    //     // RegFile[20] = 32'h00000000;
    //     // RegFile[21] = 32'h00000000;
    //     // RegFile[22] = 32'h00000000;
    //     // RegFile[23] = 32'h00000000;
    //     // RegFile[24] = 32'h00000000;
    //     // RegFile[25] = 32'h00000000;
    //     // RegFile[26] = 32'h00000000;
    //     // RegFile[27] = 32'h00000000;
    //     // RegFile[28] = 32'h00000000;
    //     // RegFile[29] = 32'h00000000;
    //     // RegFile[30] = 32'h00000000;
    //     // RegFile[31] = 32'h00000000;
    // end



endmodule



// module RegisterFile(,RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2);
// 	input reset, clk;
// 	input RegWrite;
// 	input [4:0] Read_register1, Read_register2, Write_register;
// 	input [31:0] Write_data;
// 	output [31:0] Read_data1, Read_data2;
	
// 	reg [31:0] RF_data[31:1];
	
// 	assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
// 	assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
	
// 	integer i;
// 	always @(*)
// 		if (reset)
// 			for (i = 1; i < 32; i = i + 1)
// 				RF_data[i] <= 32'h00000000;
// 		else if (RegWrite && (Write_register != 5'b00000))
// 			RF_data[Write_register] <= Write_data;

// endmodule