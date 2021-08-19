module ROM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
	input clk, 
	input [(ADDR_WIDTH-1):0] Read_addr,
	output reg [(DATA_WIDTH-1):0] Instruction
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin
		$readmemb("ROM.txt", rom);
	end
	
	always @ (posedge clk)
	begin
		Instruction <= rom[Read_addr];
	end	

endmodule
