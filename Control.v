module Control
( 
 input [5:0] opcode,
 output reg [1:0] RegDst, MemtoReg,
 output reg Jump,Branch,Bne,MemRead,MemWrite,ALUSrc,RegWrite,
 output reg [2:0] ALUOp
); 
 
 always @ *
 begin
  case(opcode)
   //R type
	6'b000000:
	begin
	 RegDst <= 2'b01;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b100;
	end
	//I type addi
	6'b001000:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	end
	//I type subi
	6'b001010:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b001;
	end
	//I type not
	6'b001100:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b101;
	end
	//I type lw
	6'b100011:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b1;
	 MemtoReg <= 2'b01;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	end
	//I type sw
	6'b101011:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b1;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	end
	//I type beq
	6'b000100:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b001;
	end
	//I type bne
	6'b000101:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b1;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b001;
	end
	//I type blt
	6'b000110:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b010;
	end
	//I type bgt
	6'b000111:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b011;
	end
	//J type j
	6'b000010:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b1;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	end
	//J type jal
	6'b000011:
	begin
	 RegDst <= 2'b10;
	 Jump <= 1'b1;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b10;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	end
	default:
	begin
	 RegDst <= 2'b00;
	 Jump <= 1'b0;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	end
  endcase
 end
endmodule