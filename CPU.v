module CPU
(
	input CLK, reset,
	output [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7
);
	wire [31:0] ALU_result,Read_Data1,Read_Data2,Address_in,Address_out,Address_4,Instruction,RAM_Read_Data,Instruction_Left;
	wire Zero,BranchCtrl,BEQ_out,BNE_out,Jump,Branch,Bne,ALUSrc,RegWrite,MemWrite,MemRead;
	wire [31:0] Write_Data,Sign,Sign_Left,ALU_Mux,ALU_result_Add,Branch_or_normal;
	wire [1:0] RegDst,MemtoReg;
	wire [2:0] ALUop;
	wire [3:0] ALUCtrl;
	wire [4:0] r31;
	wire [5:0] Write_register;
	wire Clock;
	
	assign r31 = 5'b11111;
	
	Clock Unit0(CLK,
					reset,
					Clock);
	PC Unit1(Clock,
				reset,
				Address_in,
				Address_out);
	Add Unit2(Address_out,
					32'd4,
					Address_4);
	ROM Unit3(Clock,
					Address_out[6:2],
					Instruction);
	Control Control(Instruction[31:26],
							RegDst,
							MemtoReg,
							Jump,
							Branch,
							Bne,
							MemRead,
							MemWrite,
							ALUSrc,
							RegWrite,
							ALUop);
	Mux2_N #(5) Unit4(Instruction[20:16],
								Instruction[15:11],
								r31,
								RegDst,
								Write_register);
	Registers Unit5(Clock,
							Instruction[25:21],
							Instruction[20:16],
							Write_register,
							Write_Data,
							Read_Data1,
							Read_Data2,
							RegWrite);
	Sign_extend Unit6(Instruction[15:0],
									Sign);
	Mux_N Unit7(Read_Data2,
							Sign,
							ALUSrc,
							ALU_Mux);
	ALU_control ALU_control(ALUop,
									Instruction[5:0],
									ALUCtrl);
	ALU Unit8(ALUCtrl,
				Instruction[10:6],
				Read_Data1,
				ALU_Mux,
				Zero,
				ALU_result);
	RAM Unit9(Clock,
				ALU_result[6:2],
				Read_Data2,
				MemWrite,
				MemRead,
				RAM_Read_Data);
	Mux2_N Unit10(ALU_result,
						RAM_Read_Data,
						Address_4,
						MemtoReg,
						Write_Data);
	Shift_left_2 Unit11(Sign,
								1'b0,
								Sign_Left);
	Add Unit12(Address_4,
					Sign_Left,
					ALU_result_Add);
	and(BEQ_out,
		Branch,
		Zero);
	and(BNE_out,
		Bne,
		~Zero);
	or(BranchCtrl,
		BEQ_out,
		BNE_out);
	Mux_N Unit13(Address_4,
							ALU_result_Add,
							BranchCtrl,
							Branch_or_normal);
	Shift_left_2 #(26,4) Unit14(Instruction[25:0],
											Address_4[31:28],
											Instruction_Left);
	Mux_N Unit15(Branch_or_normal,
							Instruction_Left,
							Jump,
							Address_in);
							
	IO Unit16(Clock, 
					reset, 
					MemtoReg[0], 
					ALU_result, 
					RAM_Read_Data, 
					Hex0, 
					Hex1, 
					Hex2, 
					Hex3, 
					Hex4, 
					Hex5, 
					Hex6, 
					Hex7);
	
endmodule