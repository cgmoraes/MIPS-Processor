module PC
#(parameter ADDR_WIDTH=5)
(
	input clk, reset, Enter, Input, Output,
	input [2**ADDR_WIDTH-1:0] addr,
	output reg [2**ADDR_WIDTH-1:0] out
);

	integer count = 0;

	always @ (posedge clk or posedge reset)
	begin
		if (reset) out <= 0;
		else if(!Input && !Output) out <= addr;
		else if (Enter && (count < 5)) count <= count + 1;
		else if (Enter)
		begin
			count <= 0;
			out <= addr;
		end
	end
endmodule
