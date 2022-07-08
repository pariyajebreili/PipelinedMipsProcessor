module DataMemoryTest();
    
    reg [31:0] Address;
    reg [31:0] WriteData;
    reg r_wbar;
    
    wire [31:0] ReadData;
    
    DataMemory Mem(Address, r_wbar, WriteData, ReadData);
    
    initial
    begin
        // Read Data
        Address = 32'b00000000000000000000000000000001;
        r_wbar = 1'b1;
        
        // Write Data
        #20
        Address = 32'b00000000000000000000000000010001; //17
        r_wbar = 1'b0;
        WriteData = 32'b01110001111111010110100000000110;
        
        //Read Data
        #50
        Address = 32'b00000000000000000000000000010001; //17
        r_wbar = 1'b1;
        
        //Read Data
        #20
        Address = 32'b00000000000000000000000000001101; //13
        r_wbar = 1'b1 ;
    end
    
endmodule