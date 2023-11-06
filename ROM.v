module ROM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input clk, 
	input [(ADDR_WIDTH-1):0] Read_addr,
	output reg [(DATA_WIDTH-1):0] Instruction
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin
		$readmemb("ROM.bin", rom);
	end
	
	always @ (Read_addr)
	begin
		Instruction <= rom[Read_addr];
	end	

endmodule
