`define LW     6'b100011
`define SW     6'b101011
`define BEQ    6'b000100
`define RTYPE  6'b000000

module ControlUnit (opcode,RegDst,branch,Memread,MemtoReg,ALUop,MemWrite,AluSrc,RegWrite, reset);
  
    input [5:0] opcode;
    input reset;
    output reg RegDst,branch,Memread,MemtoReg,MemWrite,AluSrc,RegWrite;
    output reg [3:0] ALUop;
    
    
    always @(posedge reset)
    begin
    RegDst <= 1'b0;
    branch <= 1'b0;
    Memread <= 1'b0;
    MemtoReg <= 1'b0;
    ALUop <= 4'b0000;
    MemWrite <= 1'b0;
    AluSrc <= 1'b0;
    RegWrite <= 1'b0;
    end

    always@(opcode)
      begin
        case (opcode)

          `RTYPE:           

            begin
            RegDst<=1 ;
            branch<=0 ;
            Memread<=0 ;
            MemtoReg<=0 ;
            MemWrite<=0 ;
            AluSrc<=0 ;
            RegWrite<=1 ;
            ALUop<=4'b0010 ;
            end
            
            
          
          `LW:           

            begin
            RegDst<=0 ;
            branch<=0 ;
            Memread<=1 ;
            MemtoReg<=1 ;
            MemWrite<=0 ;
            AluSrc<=1 ;
            RegWrite<=1 ;
            ALUop<=4'b0000 ;
            end
          
          
          `SW:           

            begin
            //RegDst<=1'bx ;
            branch<=0 ;
            Memread<=0 ;
            MemtoReg<=0 ;
            MemWrite<=1 ;
            AluSrc<=1 ;
            RegWrite<=0 ;
            ALUop<=4'b0000 ;
            end
            
          `BEQ:           

            begin
            //RegDst<=1'bx ;
            branch<= 1;
            Memread<=0 ;
            MemtoReg<=0 ;
            MemWrite<=0 ;
            AluSrc<=0 ;
            RegWrite<=0 ;
            ALUop<=4'b0001 ;
            end



        endcase
        
      end
    
  
endmodule

