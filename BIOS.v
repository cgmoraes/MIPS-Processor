module BIOS
( 
 input clk, interruptionProcess, MemRead, MemWrite,
 input [15:0] instruction_imm,
 input [31:0] Read_Data1, Read_Data2, Last_addr,
 output reg [15:0] immediate
); 

 reg [31:0] Base_addr, mem_addr;
 
 initial
 begin
	Base_addr <= 32'd0;
	mem_addr <= 32'd0;
 end
 
 always @(negedge clk)
 begin
	if (interruptionProcess) begin
		Base_addr <= Read_Data1;
		mem_addr <= Read_Data2+32'd16;
	end
	
	if ({MemRead, MemWrite} > 2'd0) immediate = instruction_imm + mem_addr[15:0];
	else immediate = instruction_imm;

 end
 
endmodule