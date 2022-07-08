`timescale 1ns/1ns
module mux_2_to_1_5bits (Input0, Input1, Selector, Output1);
    input [4:0] Input0, Input1;
    input Selector;
    
    output reg [4:0] Output1;
    
    always @(*)
    begin
        Output1 = (Selector == 1'b0) ? Input0 : Input1;
    end
endmodule

