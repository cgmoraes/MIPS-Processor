//module CPU
//(
//	input CLK, reset, Enter,
//	input [9:0] sw, 
//	input [1:0] freq,
//	output [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7
//);
//	
//	wire Clock,Input,Output,Halt, RegWrite, MemWrite, MemRead, Zero, BranchCtrl;
//	wire BEQ_out, BNE_out,Branch,Bne, ALUSrc;
//	wire [1:0] Jump,RegDst, MemtoReg;
//	wire [2:0] ALUop;
//	wire [3:0] ALUCtrl;
//	wire [4:0] Write_register, r31, r28;
//	wire [31:0] Address_out, ALU_result, Read_Data1, Read_Data2, Sign, Write_Data;
//	wire [31:0] Instruction,RAM_Read_Data,Instruction_Left, Process_addr, Input_Data;
//	wire [31:0] Sign_Left,ALU_Mux,ALU_result_Add, Branch_or_normal, Address_in;
	
module CPU
(
	input CLK, reset, Enter,
	input [9:0] sw, 
	input [1:0] freq,
	output [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7,
	output [31:0] Address_out, Read_Data1,Read_Data2,  Last_addr, Address_4,
	output [31:0] Process_addr,  ALU_result_Add, Address_in, Base_addr, mem_addr, Data,
	output [31:0] Instruction, Time_quantum,
	output [4:0] Write_register,
	output [1:0] Jump,RegDst, MemtoReg, Halt,
	output Clock,ctx, getAddr, quantum, interruptionProcess 
);
	wire RegWrite,MemWrite,MemRead,Zero,BranchCtrl,BEQ_out, BNE_out,Branch,Bne, ALUSrc, setQuantum,Input,Output;
	wire [31:0] Branch_or_normal, ALU_result, Input_Data, RAM_Read_Data, Instruction_Left;
	wire [31:0] ALU_Mux, Write_Data, Sign_Left, Sign;
	wire [4:0] r31, r28;
	wire [3:0] ALUCtrl;
	wire [2:0] ALUop;
	
	Clock Unit0(CLK,
					reset,
					ctx,
					Halt,
					freq,
					Clock);
	Timer Unit18(Clock,
					 setQuantum,
					 Read_Data1,
					 Time_quantum);
	InterruptionController Unit19(Clock,
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
					Address_out[11:2],
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
	Mux_N Unit20(Write_Data,
					 Last_addr >> 2,
					 getAddr,
					 Data);
	Shift_left_2 Unit12(Sign,
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
	Shift_left_2_concat Unit15(Instruction[25:0],
											Address_4[31:28],
											Base_addr,
											Instruction_Left);
	Mux3_N Unit16(Branch_or_normal,
							Instruction_Left,
							Read_Data1,
							Read_Data1 << 2,
							Jump,
							Address_in);
	IO Unit17(Clock, 
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
					
//  test Unit33(Clock, ctx, quantum, Halt[1], {2'b00,Address_out[31:2]}+32'd1, {2'b00,Last_addr[31:2]}+32'd1, Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7);
	
endmodule