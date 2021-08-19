module PC
#(parameter ADDR_WIDTH=5)
(
	input clk, reset,
	input [2**ADDR_WIDTH-1:0] addr,
	output reg [2**ADDR_WIDTH-1:0] out
);

	always @ (posedge clk or negedge reset)
	begin
		if (!reset) out <= 0;
		else out <= addr;
	end
endmodule
