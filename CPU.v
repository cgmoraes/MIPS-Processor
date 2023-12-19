module CPU
(
	input CLK, reset, Enter,
	input [9:0] sw, 
	input [1:0] freq,
	output [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7,
	inout [7:0] LCD_DATA,
	output LCD_ON,	LCD_BLON, LCD_RW,	LCD_EN, LCD_RS
	
);
	wire Clock,ctx, getAddr, quantum, interruptionProcess,RegWrite,MemWrite,MemRead,Zero;
	wire BranchCtrl,BEQ_out, BNE_out,Branch,Bne,ALUSrc,setLCD,setQuantum,Input,Output;
	wire [31:0] Branch_or_normal, ALU_result, Input_Data, RAM_Read_Data, Instruction_Left;
	wire [31:0] ALU_Mux, Write_Data, Sign_Left, Sign, Instruction, Time_quantum, mem_addr;
	wire [31:0] Address_out,Read_Data1,Read_Data2,  Last_addr, Address_4,Data;
	wire [31:0] ALU_result_Add, Address_in, Base_addr;
	wire [4:0] r31, r28, Write_register;
	wire [3:0] ALUCtrl;
	wire [2:0] ALUop;
	wire [1:0] Jump,RegDst, MemtoReg, Halt;

	
	Clock Unit0(CLK,
					reset,
					ctx,
					Halt,
					freq,
					Clock);
	Timer Unit20(Clock,
					 setQuantum,
					 Read_Data1,
					 Time_quantum);
	InterruptionController Unit21(Clock,
											reset,
											quantum,
											interruptionProcess,
											Halt,
											ctx);
	PC Unit1(Clock,
				reset,
				ctx,
				Enter,
				Input,
				Output,
				interruptionProcess,
				Halt,
				Read_Data2,
				Address_4,
				Address_in,
				Time_quantum,
				quantum, 
				r31,
				r28,
				Base_addr,
				mem_addr,
				Last_addr,
				Address_out);
	Add Unit2(Address_out,
					32'd4,
					Address_4);
	ROM Unit3(Clock,
					Address_out[31:2],
					Instruction);
	Control Unit4(Instruction[31:26],
							RegDst,
							MemtoReg,
							Jump,
							Halt,
							Input,
							Output,
							Branch,
							Bne,
							MemRead,
							MemWrite,
							ALUSrc,
							RegWrite,
							interruptionProcess,
							setLCD,
							setQuantum,
							getAddr,
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
							Data,
							Read_Data1,
							Read_Data2,
							RegWrite);
	Sign_extend Unit7(Instruction[15:0],
							Jump[0],
							MemRead, 
							MemWrite,
							mem_addr,
							Sign);
	Mux_N Unit8(Read_Data2,
							Sign,
							ALUSrc,
							ALU_Mux);
	ALU_control Unit9(ALUop,
									Instruction[5:0],
									ALUCtrl);
	ALU Unit10(ALUCtrl,
				Instruction[10:6],
				Read_Data1,
				ALU_Mux,
				Zero,
				ALU_result);
	RAM Unit11(CLK,
				Clock,
				ALU_result,
				Read_Data2,
				MemWrite,
				MemRead,
				RAM_Read_Data);
	Mux3_N Unit12(ALU_result,
						RAM_Read_Data,
						Address_4,
						Input_Data,
						MemtoReg,
						Write_Data);
	Mux_N Unit13(Write_Data,
					 Last_addr >> 2,
					 getAddr,
					 Data);
	Shift_left_2 Unit14(Sign,
								Sign_Left);
	Add Unit15(Address_4,
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
	Mux_N Unit16(Address_4,
							ALU_result_Add,
							BranchCtrl,
							Branch_or_normal);
	Shift_left_2_concat Unit17(Instruction[25:0],
											Address_4[31:28],
											Base_addr,
											Instruction_Left);
	Mux3_N Unit18(Branch_or_normal,
							Instruction_Left,
							Read_Data1,
							Read_Data1 << 2,
							Jump,
							Address_in);
	IO Unit19(Clock, 
					reset,
					Input,
					Output,
					Halt[1],
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
	LCD Unit22(CLK,
				  Clock,
				  setLCD,
				  Read_Data1,
				  LCD_DATA,
				  LCD_ON,
				  LCD_BLON,
				  LCD_RW,
				  LCD_EN,
			     LCD_RS);
endmodule