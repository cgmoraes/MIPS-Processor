module RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=6)
(
	input clk,
	input [(ADDR_WIDTH-1):0] addr,
	input [(DATA_WIDTH-1):0] Write_data,
	input MemWrite, MemRead,
	output [(DATA_WIDTH-1):0] Read_data
);

	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	always @ (negedge clk)
	begin
		if (MemWrite) ram[addr] <= Write_data;
	end
	
	assign Read_data = ram[addr];
endmodule
