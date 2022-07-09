`timescale 1ns/1ns
// module Mips(clk, rst, pc_in , PCNext, Instruction, ReadData1, ReadData2,  WriteDataReg,
//       WriteReg, Zero, branch, RegDst, RegWrite, MemToReg, ALUSrc, MemRead, MemWrite, ALUOperation);
module Mips();
	reg clk,rst;
	
	// output wire [4:0] WriteReg;
	// output wire [31:0] Instruction,ReadData1, ReadData2,WriteDataReg;
	// output wire [31:0] pc_in, PCNext;
	// output wire RegDst, RegWrite, MemToReg,ALUSrc,
	// Zero, MemRead, MemWrite, branch;
	// output wire [1:0] ALUOperation;

	// wire [31:0] AddAluOut,ShiftOut,extend32, alu_b, alu_out, MemReadData;
	// wire branch_zero_and;
	// wire [31:0] PCPlusOne, branchAddress;

	/* ####################################################################################################### */


	// IF registers
	wire [31:0] InstructionIF, PCPlusOneIF;

	// ID registers
	wire [31:0] ReadData1ID, ReadData2ID;
	wire [31:0] InstructionID, PCPlusOneID, extend32ID;
	wire RegDstID, RegWriteID, MemToRegID,ALUSrcID,
				ZeroID, MemReadID, MemWriteID, branchID;
	wire [1:0] ALUOperationID; 

	// EX registers
	wire [31:0] PCPlusOneEX, ReadData1EX, ReadData2EX,
	extend32EX, ALUResultEX;
	wire [4:0] RsEX, RtEX, RdEX;
	wire MemReadEX, MemWriteEX, RegWriteEX, MemToRegEX,
	ALUSrcEX, RegDstEX;
	wire [1:0] ALUOperationEX;

	// MEM registers
	wire [31:0] WriteDataRegMEM /* why not WB? */, 
	ALUResultMEM, MemReadDataMEM, MemWriteDataMEM /* ????? it's always ReadData2 */;
	wire [4:0] WriteRegMEM;
	wire RegWriteMEM, MemtoRegMEM, MemWriteMEM, 
	MemReadMEM;

	// WB registers
	wire [4:0] WriteRegWB;
	wire [31:0] ALUResultWB, MemReadDataWB;
	wire RegWriteWB, MemtoRegWB;

	/* ************** */
	wire [4:0] RegMuxOut;
	wire stallPC, stallIF_ID;
	wire [31:0] pc_in, PCNext;
	wire [31:0] branchAddress;
	wire branch_zero_and;
	wire [31:0] ALUData1, ALUData2;
	wire [31:0] comparatorMux1Out, comparatorMux2Out;
	wire equalFlag;
	wire [1:0] comparatorMux1Selector, comparatorMux2Selector,
	FirstMuxSel, SecondMuxSel;
	wire [31:0] ALUData2Mux_1Out;
	// wire [9:0] controlSignalsID;

	IFIDReg IF_ID (clk, PCPlusOneIF, InstructionIF, InstructionID, PCPlusOneID, stallIF_ID, branch_zero_and);


	IDEXReg ID_EX (
		.clk(clk),
		.RegWrite(RegWriteID),
		.MemtoReg(MemtoRegID), 
		.MemWrite(MemWriteID),
		.MemRead(MemReadID), 
		.ALUSrc(ALUSrcID), 
		.ALUOp(ALUOperationID), 
		.RegDst(RegDstID),
	    .PCplusOne(PCPlusOneID), 
		.ReadData1_in(ReadData1ID), 
		.ReadData2_in(ReadData2ID), 
		.RegisterAddresses(InstructionID[25:11]),
		.SignExtendResult_in(extend32ID), 
		.PCplusOneout(PCPlusOneEX), 
		.ReadData1_out(ReadData1EX), 
		.ReadData2_out(ReadData2EX), 
		.SignExtendResult_out(extend32EX), 
		.rsOut(RsEX), 
		.rtOut(RtEX), 
		.rdOut(RdEX),
		.RegWriteOut(RegWriteEX), 
		.MemtoRegOut(MemToRegEX), 
		.MemWriteOut(MemWriteEX), 
		.MemReadOut(MemReadEX), 
		.ALUSrcOut(ALUSrcEX), 
		.ALUOpOut(ALUOperationEX), 
		.RegDstOut(RegDstEX)
		);


	EXMemReg EX_MEM (clk, RegWriteEX, MemtoRegEX, MemWriteEX, MemReadEX, ALUResultEX, ALUData2Mux_1Out,
	RegMuxOut, RegWriteMEM, MemtoRegMEM, MemWriteMEM, MemReadMEM, ALUResultMEM, MemWriteDataMEM, WriteRegMEM);


	MemWbReg MEM_WB (clk, RegWriteMEM, MemtoRegMEM, ALUResultMEM, MemReadDataMEM /* change mem out */ ,
	WriteRegMEM, RegWriteWB, MemToRegWB, MemReadDataWB, ALUResultWB, WriteRegWB);





	mux_3_to_1_32bits EX_FirstMux(ALUData1, ReadData1EX, WriteDataRegMEM, ALUResultMEM, FirstMuxSel);

	mux_3_to_1_32bits EX_SecondMux(ALUData2Mux_1Out, ReadData2EX, WriteDataRegMEM, ALUResultMEM, SecondMuxSel);

	mux_2_to_1_5bits EX_ThirdMux(RegMuxOut, RtEX, RdEX, RegDstEX);

	mux_2_to_1_32bits Mux_After_EX_SecondMux(ALUData2, ALUData2Mux_1Out, extend32EX, ALUSrcEX);

	/* Awwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww */
	// mux_2_to_1_10bits ID_EXRegMux(controlSignalsID, {RegWriteID, MemtoRegID, MemWriteID, MemReadID, ALUSrcID, ALUOpID, RegDstID}
	// 		,10'b0000000000, hazardMuxSelector);

	HazardDetection hazardUnit(MemReadEX, MemReadMEM, RtEX, InstructionID, stallPC, stallIF_ID, hazardMuxSelector);


	Forwarding forwardingUnit(RegWriteMEM, WriteRegMEM, RegWriteWB, WriteRegWB, RsEX, RtEX
			,FirstMuxSel,SecondMuxSel, comparatorMux1Selector,comparatorMux2Selector);

	// forwarding multiplexers before alu
	mux_3_to_1_32bits comparatorMux1(comparatorMux1Out, ReadData1ID, ALUResultMEM, WriteDataRegMEM, comparatorMux1Selector);
	mux_3_to_1_32bits comparatorMux2(comparatorMux2Out, ReadData2ID, ALUResultMEM, WriteDataRegMEM, comparatorMux2Selector);

	// branch hazard comparator
	Comparator comparator(comparatorMux1Out, comparatorMux2Out, equalFlag);

	mux_2_to_1_32bits WB_Mux(WriteDataRegMEM, ALUResultWB, MemReadDataMEM, MemtoRegWB);


	/* ####################################################################################################### */

	and(branch_zero_and, branchID, equalFlag);

	ProgramCounter PC(.clk(clk), .rst(rst), .PcNext(PCNext), .PcIn(pc_in));
   


	SignExtend SE16TO32(InstructionID[15:0],extend32ID);


	Adder PcAdder(.In1(pc_in), .In2(32'h00000001),.AddAluOut(PCPlusOneIF));

	Adder BranchAdder(.In1(PCPlusOneID), .In2(extend32ID),.AddAluOut(branchAddress));

	mux_2_to_1_32bits mux_after_pc_adder(.Input0(PCPlusOneIF), .Input1(branchAddress),
       .Selector(branch_zero_and), .Output1(PCNext));

	IntructionMemory IM(.Address(pc_in), .Instruction(InstructionIF));

      
	// mux_2_to_1_5bits mux_before_regfile(.Input0(InstructionID[20:16]), .Input1(InstructionID[15:11]),
    //    .Selector(RegDst), .Output1(WriteReg));

	RegisterFile RF(.clk(clk), .rst(rst), .ReadRegister1(InstructionID[25:21]), .ReadRegister2(InstructionID[20:16]),
	.WriteData(WriteDataRegMEM), .WriteReg(WriteRegWB),
	.RegWriteActive(RegWriteWB), .ReadData1(ReadData1ID), .ReadData2(ReadData2ID));


	// ALU Unit
	// ALUData2Mux_2
	// mux_2_to_1_32bits mux_after_regfile(.Input0(ReadData2), .Input1(extend32), .Selector(ALUSrc), .Output1(alu_b));
	ALU alu(.Operand1(ALUData1), .Operand2(ALUData2), .ALUControl(ALUOperationID), .ALUResult(ALUResultEX), .Zero(Zero));
	// ALU alu(.Operand1(ReadData1), .Operand2(alu_b), .ALUControl(ALUOperation), .ALUResult(alu_out), .Zero(Zero));


	//Control Unit
	Controller controller(.func(InstructionID[5:0]), .opcode(InstructionID[31:26]),.RegDst(RegDstID),.RegWrite(RegWriteID), .ALUSrc(ALUSrcID),
	.MemToReg(MemToRegID), .MemRead(MemReadID), .MemWrite(MemWriteID),.branch(branchID),.ALUOperation(ALUOperationID));


      // Data memory
      DataMemory DM(.Address(ALUResultMEM), .rbar_w(MemWriteMEM),
      .WriteData(MemWriteDataMEM), .ReadData(MemReadDataMEM));
	// mux_2_to_1_32bits mux_affter_memory(.Input0(alu_out), .Input1(MemReadData), .Selector(MemToReg), .Output1(WriteDataReg));


always@(clk)
	#100 clk <= ~clk;

	initial
	begin

	clk <= 0;
	rst <= 1;
	#50
	rst <= 0;

end

endmodule



