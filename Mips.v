`timescale 1ns/1ns
module Mips(clk, rst, pc_in , PCNext, Instruction, ReadData1, ReadData2,  WriteDataReg,
      WriteReg, Zero, branch, RegDst, RegWrite, MemToReg, ALUSrc, MemRead, MemWrite, ALUOperation);
	
	input clk,rst;
	
	output wire [4:0] WriteReg;
	output wire [31:0] Instruction,ReadData1, ReadData2,WriteDataReg;
	output wire [31:0] pc_in, PCNext;
	output wire RegDst, RegWrite, MemToReg,ALUSrc,
	Zero, MemRead, MemWrite, branch;
	output wire [1:0] ALUOperation;

	wire [31:0] AddAluOut,ShiftOut,extend32, alu_b, alu_out, MemReadData;
	wire branch_zero_and;
	wire [31:0] PCPlusOne, branchAddress;


	// // IF registers
	// wire [31:0] InstructionIF, PCPlusOneIF;
	// // ID registers
	// wire [31:0] ReadData1ID, ReadData2ID;
	// wire [31:0] InstructionID, PCPlusOneID;
	// wire RegDstID, RegWriteID, MemToRegID,ALUSrcID,
	// 			ZeroID, MemReadID, MemWriteID, branchID;
	// wire [1:0] ALUOperation;
	// // EX registers

	// // MEM registers
	// wire [31:0] WriteDataRegMEM;
	// // WB registers
	// wire [4:0] writeRegWB;
	// wire RegWriteWB;


	and(branch_zero_and, branch, Zero);
	// ProgramCounter PC(.clk(clk), .rst(rst), .PcIn(pc_in), .new_pc(AddAluOut), .branch_zero_and(branch_zero_and), .PcNext(pc_in));
	ProgramCounter PC(.clk(clk), .rst(rst), .PcNext(PCNext), .PcIn(pc_in));
   


	//Orginal Unit
	SignExtend SE16TO32(Instruction[15:0],extend32);


	Adder PcAdder(.In1(pc_in), .In2(32'h00000001),.AddAluOut(PCPlusOne));

	Adder BranchAdder(.In1(PCPlusOne), .In2(extend32),.AddAluOut(branchAddress));
	// PcAdder PCADDER(.PcNext(pc_in), .ShiftOut(extend32),.AddAluOut(AddAluOut));


	mux_2_to_1_32bits mux_after_pc_adder(.Input0(PCPlusOne), .Input1(branchAddress),
       .Selector(branch_zero_and), .Output1(PCNext));

	IntructionMemory IM(.Address(pc_in), .Instruction(Instruction));

      
	mux_2_to_1_5bits mux_before_regfile(.Input0(Instruction[20:16]), .Input1(Instruction[15:11]),
       .Selector(RegDst), .Output1(WriteReg));

      RegisterFile RF(.clk(clk), .rst(rst), .ReadRegister1(Instruction[25:21]), .ReadRegister2(Instruction[20:16]),
      .WriteData(WriteDataReg), .WriteReg(WriteReg),
      .RegWriteActive(RegWrite), .ReadData1(ReadData1), .ReadData2(ReadData2));


      // ALU Unit
	mux_2_to_1_32bits mux_after_regfile(.Input0(ReadData2), .Input1(extend32), .Selector(ALUSrc), .Output1(alu_b));
      ALU alu(.Operand1(ReadData1), .Operand2(alu_b), .ALUControl(ALUOperation), .ALUResult(alu_out), .Zero(Zero));


	//Control Unit
      Controller controller(.func(Instruction[5:0]), .opcode(Instruction[31:26]),.RegDst(RegDst),.RegWrite(RegWrite), .ALUSrc(ALUSrc),
      .MemToReg(MemToReg), .MemRead(MemRead), .MemWrite(MemWrite),.branch(branch),.ALUOperation(ALUOperation));


      // Data memory
      DataMemory DM(.Address(alu_out), .rbar_w(MemWrite),
      .WriteData(ReadData2), .ReadData(MemReadData));
	mux_2_to_1_32bits mux_affter_memory(.Input0(alu_out), .Input1(MemReadData), .Selector(MemToReg), .Output1(WriteDataReg));

	

endmodule
