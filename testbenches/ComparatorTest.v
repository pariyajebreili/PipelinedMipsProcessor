module TestCom();
    reg [31:0] in1, in2;
    wire out;

    
    Comparator com (in1, in2, out);

    initial
    begin
        in1 = 32'h00000000;
        in2 = 32'h00000000;
        
        #20
        in1 = 32'h00000010;
        in2 = 32'h00000000;

        #20
        in1 = 32'h10000010;
        in2 = 32'h11000000;

        #20
        in1 = 32'h00000010;
        in2 = 32'h00000010;



    end
endmodule
