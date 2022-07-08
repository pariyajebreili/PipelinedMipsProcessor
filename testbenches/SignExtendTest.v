module SignExtendTest();
    
    reg [15:0] Input1;
    
    wire [31:0] Output1;
    
    SignExtend UUT(Input1, Output1);
    
    initial
    begin
        Input1 = 16'b1000000000000000;
        
        #100
        Input1 = 16'b0010000000000000;
        
        #100
        Input1 = 16'b0110000000000000;
        
        #100
        Input1 = 16'b1111111111111111;
    end
endmodule
