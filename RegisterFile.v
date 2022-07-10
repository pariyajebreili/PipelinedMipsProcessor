module RegisterFile(ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite, Clk, ReadData1, ReadData2, reset);


	input [4:0] ReadReg1 ,ReadReg2 ,WriteReg;
	input [31:0] WriteData;
	input RegWrite ,Clk, reset;
	output reg [31:0] ReadData1 ,ReadData2;

	reg [31:0] RegFile[0:31];

	always @(posedge reset) 
		begin
		RegFile[0] <= 32'h00000000;
		RegFile[8] <= 32'h00000001;
		RegFile[9] <= 32'h00000002;
		RegFile[10] <= 32'h00000000;
		RegFile[11] <= 32'h00000000;
		RegFile[12] <= 32'h00000000;
		RegFile[13] <= 32'h00000000;
		RegFile[14] <= 32'h00000000;
		RegFile[15] <= 32'h00000000;
		RegFile[16] <= 32'h00000000;
		RegFile[17] <= 32'h00000000;
		RegFile[18] <= 32'h00000003;
		RegFile[19] <= 32'h00000003;
		RegFile[20] <= 32'h00000004;
		RegFile[21] <= 32'h00000000;
		RegFile[22] <= 32'h00000008;
		RegFile[23] <= 32'h00000000;
		RegFile[24] <= 32'h00000000;
		RegFile[25] <= 32'h00000000;
		RegFile[31] <= 32'h00000000;
		end

	always @(ReadReg1, ReadReg2)
	begin
		ReadData1 <= RegFile[ReadReg1];
  		ReadData2 <= RegFile[ReadReg2];
	end

	always @(negedge Clk)
  	begin
  		if (RegWrite == 1)
		begin
			 RegFile[WriteReg] <= WriteData;
      		end
  	end



endmodule

