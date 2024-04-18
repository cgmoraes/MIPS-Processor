module Control
( 
 input [5:0] opcode,
 output reg [1:0] RegDst, MemtoReg, Jump, Halt, print,
 output reg Input,Output,Branch,Bne,MemRead,MemWrite,ALUSrc,RegWrite,
 output reg interruptionProcess,setLCD,setQuantum,getAddr,
 output reg [2:0] ALUOp
); 
 
 always @ *
 begin
  case(opcode)
   //R type
	6'b000000:
	begin
	 RegDst <= 2'b01;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b101;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type addi
	6'b001000:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type subi
	6'b001010:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b001;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type not
	6'b001100:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b100;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type lw
	6'b100011:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b1;
	 MemtoReg <= 2'b01;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type sw
	6'b101011:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b1;
	 ALUSrc <= 1'b1;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type beq
	6'b000100:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b001;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type bne
	6'b000101:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b1;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b001;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type blt
	6'b000110:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b010;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//I type bgt
	6'b000111:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b1;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b011;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//J type j
	6'b000010:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b01;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//J type jal
	6'b000011:
	begin
	 RegDst <= 2'b10;
	 Jump <= 2'b01;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b10;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//J type jr
	6'b000001:
	begin
	 RegDst <= 2'b10;
	 Jump <= 2'b10;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//input
	6'b100001:
	begin
	 RegDst <= 2'b11;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b11;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b1;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//output
	6'b110001:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b1;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//HALT
	6'b111111:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b10;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//HALT
	6'b111101:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b01;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//Change Context
	6'b101001:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b11;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b1;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//Set Quantum
	6'b101111:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b1;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	//Get address
	6'b100111:
	begin
	 RegDst <= 2'b11;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b1;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b1;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
	// Set LCD
	6'b101101:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b1;
	 print <= 2'b00;
	end
	//Set Position
	6'b011110:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b01;
	end
	//Print
	6'b110111:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b10;
	end
	default:
	begin
	 RegDst <= 2'b00;
	 Jump <= 2'b00;
	 Branch <= 1'b0;
	 Bne <= 1'b0;
	 MemRead <= 1'b0;
	 MemtoReg <= 2'b00;
	 MemWrite <= 1'b0;
	 ALUSrc <= 1'b0;
	 RegWrite <= 1'b0;
	 ALUOp <= 3'b000;
	 Halt <= 2'b00;
	 Output <= 1'b0;
	 Input <= 1'b0;
    interruptionProcess <= 1'b0;
	 setQuantum <= 1'b0;
	 getAddr <= 1'b0;
	 setLCD <= 1'b0;
	 print <= 2'b00;
	end
  endcase
 end
endmodule