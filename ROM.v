module ROM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=4400)
(
	input clk, 
	input [29:0] Read_addr,
	output reg [(DATA_WIDTH-1):0] Instruction
);

	reg [DATA_WIDTH-1:0] rom[ADDR_WIDTH:0];

	initial
	begin
		$readmemb("ROM.bin", rom);
	end
	
	always @ (Read_addr)
	begin
		Instruction <= rom[Read_addr];
	end	

endmodule
