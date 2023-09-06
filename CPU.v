module CPU
(
	input CLK, reset, Enter,
	input [9:0] sw, 
	input [1:0] freq,
	output [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7,
	output [31:0] Address_out, ALU_result, Read_Data1,Read_Data2, Sign, Write_Data, Address_4,
	output [31:0] Instruction,RAM_Read_Data,Instruction_Left, Input_Data,
	output [1:0] Jump,RegDst, MemtoReg,
	output Clock,Input,Output,Halt
);
	wire RegWrite,MemWrite,MemRead,Zero,BranchCtrl,BEQ_out, BNE_out,Branch,Bne, ALUSrc;
	wire [31:0] Branch_or_normal, Address_in;
	wire [31:0] Sign_Left,ALU_Mux,ALU_result_Add;
	wire [4:0] Write_register,r31, r28;
	wire [3:0] ALUCtrl;
	wire [2:0] ALUop;
	
	assign r31 = 5'b11111;
	assign r28 = 5'b11100;
	
	Clock Unit0(CLK,
					reset,
					Halt,
					freq,
					Clock);
	PC Unit1(Clock,
				reset,
				Enter,
				Input,
				Output,
				Address_in,
				Address_out);
	Add Unit2(Address_out,
					32'd4,
					Address_4);
	ROM Unit3(Clock,
					Address_out[11:2],
					Instruction);
	Control Unit4(Instruction[31:26],
							RegDst,
							MemtoReg,
							Jump,
							Input,
							Output,
							Halt,
							Branch,
							Bne,
							MemRead,
							MemWrite,
							ALUSrc,
							RegWrite,
							ALUop);
	Mux3_N #(5) Unit5(Instruction[20:16],
								Instruction[15:11],
								r31,
								r28,
								RegDst,
								Write_register);
	Registers Unit6(Clock,
							Instruction[25:21],
							Instruction[20:16],
							Write_register,
							Write_Data,
							Read_Data1,
							Read_Data2,
							RegWrite);
	Sign_extend Unit7(Instruction[15:0],
									Sign);
	Mux_N Unit8(Read_Data2,
							Sign,
							ALUSrc,
							ALU_Mux);
	ALU_control ALU_control(ALUop,
									Instruction[5:0],
									ALUCtrl);
	ALU Unit9(ALUCtrl,
				Instruction[10:6],
				Read_Data1,
				ALU_Mux,
				Zero,
				ALU_result);
	RAM Unit10(Clock,
				ALU_result[9:0],
				Read_Data2,
				MemWrite,
				MemRead,
				RAM_Read_Data);
	Mux3_N Unit11(ALU_result,
						RAM_Read_Data,
						Address_4,
						Input_Data,
						MemtoReg,
						Write_Data);
	Shift_left_2 Unit12(Sign,
								1'b0,
								Sign_Left);
	Add Unit13(Address_4,
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
	Mux_N Unit14(Address_4,
							ALU_result_Add,
							BranchCtrl,
							Branch_or_normal);
	Shift_left_2 #(26,4) Unit15(Instruction[25:0],
											Address_4[31:28],
											Instruction_Left);
	Mux2_N Unit16(Branch_or_normal,
							Instruction_Left,
							Read_Data1,
							Jump,
							Address_in);
	IO Unit17(Clock, 
					reset,
					Input,
					Output,
					Halt,
					Enter,
					sw,
					Read_Data1,
					Input_Data,
					Hex0, 
					Hex1, 
					Hex2, 
					Hex3, 
					Hex4, 
					Hex5, 
					Hex6, 
					Hex7);
	
endmodule