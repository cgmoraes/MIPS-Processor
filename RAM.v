module RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=4400)
(
	input clk_50, clk,
	input [(DATA_WIDTH-1):0] addr,
	input [(DATA_WIDTH-1):0] Write_data,
	input MemWrite, MemRead,
	output reg [(DATA_WIDTH-1):0] Read_data
);

	reg [DATA_WIDTH-1:0] ram[ADDR_WIDTH:0];
	initial 
	begin : INIT
		integer i;
		for(i = 0; i < ADDR_WIDTH; i = i + 1)
			ram[i] = {DATA_WIDTH{1'b0}};
	end 

	always @ (negedge clk)
	begin
		if (MemWrite) ram[addr] <= Write_data;
	end
	
	always @ (posedge clk_50)
	begin
		Read_data <= ram[addr];
	end
endmodule
