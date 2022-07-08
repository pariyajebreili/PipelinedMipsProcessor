module InstructionMemoryTest();
    
    reg [31:0] Address;
    wire [31:0] Instruction;
    
    IntructionMemory InsMem(Address, Instruction);
    
    initial begin

        // Read instructions
        Address = 32'b00000000000000000000000000000000;
        
        #20
        Address = 32'b00000000000000000000000000000001;
        
        #20
        Address = 32'b00000000000000000000000000000111;
        
        #20
        Address = 32'b00000000000000000000000000000011;
        
        
        #20
        Address = 32'b00000000000000000000000000000100;        
    end
endmodule