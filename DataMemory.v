`timescale 1ns/1ns
module  DataMemory (Address, rbar_w, WriteData, ReadData);
   
   // rbar_w: control signal - Not Read Or Write
   // rbar_w = 1 => Write
   // rbar_w = 0 => Read
   
      input rbar_w;
	input wire [31:0] Address,WriteData;
	output reg [31:0] ReadData;

  	reg [31:0] Mem[0:255];

	integer i;

	initial begin
			for (i = 0; i < 256; i = i + 1) begin
				Mem[i] = i;
			end
	end

	always @(*) 
	begin
	      if(rbar_w == 1)
	      begin
	         // Write
	         Mem[Address] = WriteData;
	      end
	      else
	      begin
	         // Read
        	   ReadData = Mem[Address];      
         end
	end

endmodule