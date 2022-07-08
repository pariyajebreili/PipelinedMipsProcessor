
module RegisterFileTest();

    reg [4:0] ReadRegister1; 
    reg [4:0] ReadRegister2;
    reg [4:0] WriteReg;
    reg [31:0] WriteData;
    reg RegWriteActive;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    RegisterFile RegFile(ReadRegister1, ReadRegister2, WriteData, WriteReg,
                         RegWriteActive, ReadData1, ReadData2);

    initial begin
        // Read register 4 and 7 data
        ReadRegister1 = 5'b00100;
        ReadRegister2 = 5'b00111;
        RegWriteActive = 1'b0;

        // Testing the RegWriteActive signal. when the signal is 0 or x, the data won't be written.        
        #20
        WriteData = 32'b00000000000000000000000100010010;
        WriteReg = 5'b00000;
        RegWriteActive = 1'b0;
        
        // Register 0 won't effect.
        #20
        ReadRegister1 = 5'b00000;
        
        // Writing data
        #20
        WriteData = 32'b10000000000000000000000000000000;
        WriteReg = 5'b10000;
        RegWriteActive = 1'b1;
        
        // Reading the written data
        #20
        ReadRegister1 = 5'b10000;
        
        #20
        ReadRegister1 = 5'b00001;        
                #20
        ReadRegister1 = 5'b00010;        
                #20
        ReadRegister1 = 5'b00011;        
                #20
        ReadRegister1 = 5'b01001;        
                #20
        ReadRegister1 = 5'b00101;        
                #20
        ReadRegister1 = 5'b01010;        
        
    end
endmodule