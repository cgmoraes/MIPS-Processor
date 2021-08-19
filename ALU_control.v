module ALU_control
(
 input [2:0] ALUOp,
 input [5:0] Funct,
 output reg [3:0] ALUCtrl
);
 
 always @(ALUOp,Funct)
 begin
  case(ALUOp)
  3'b000: ALUCtrl <= 4'd2; //addi, lw, sw
  3'b001: ALUCtrl <= 4'd3; //subi, beq, bne
  3'b010: ALUCtrl <= 4'd4; //blt
  3'b011: ALUCtrl <= 4'd5; //bgt
  3'b101: ALUCtrl <= 4'd6; //not
  3'b100:
  begin
   case(Funct)
   6'b100100: ALUCtrl <= 4'd0;  //and
   6'b100101: ALUCtrl <= 4'd1;  //or
   6'b100000: ALUCtrl <= 4'd2;  //add
   6'b100010: ALUCtrl <= 4'd3;  //sub
	6'b011000: ALUCtrl <= 4'd7;  //mult
	6'b011010: ALUCtrl <= 4'd8;  //div
	6'b000000: ALUCtrl <= 4'd9;  //sll
	6'b000001: ALUCtrl <= 4'd10; //srl
   default: ALUCtrl <= 4'b1111;
   endcase
  end
  default: ALUCtrl <= 4'b1111;
  endcase
 end
endmodule