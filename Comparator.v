module Comparator(Input1, Input2, Out);
    input [31:0] Input1, Input2;
    output Out;

    assign Out = (Input1 - Input2 == 0) ? 1'b1 : 1'b0;
endmodule

