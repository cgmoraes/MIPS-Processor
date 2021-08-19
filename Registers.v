module Registers
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
 input clk,
 input [(ADDR_WIDTH-1):0] Read_reg1, Read_reg2, Write_regs,
 input [(DATA_WIDTH-1):0] Write_Data,
 output [(DATA_WIDTH-1):0] Read_Data1, Read_Data2,
 input RegWrite
);

 reg [DATA_WIDTH-1:0] registers[2**ADDR_WIDTH-1:0];
 
 assign Read_Data1 = registers[Read_reg1];
 assign Read_Data2 = registers[Read_reg2];

 always @(posedge clk)
 begin
	if (RegWrite) registers[Write_regs] <= Write_Data;
 end
endmodule
