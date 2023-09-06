module PC
#(parameter ADDR_WIDTH=5)
(
	input clk, reset, Enter, Input, Output,
	input [2**ADDR_WIDTH-1:0] addr,
	output reg [2**ADDR_WIDTH-1:0] out
);
	
	reg prev_enter = 0;


	always @ (posedge clk or posedge reset)
	begin
		if (reset) begin
		out <= 0;
		prev_enter <= 0;
		end else if(!Input && !Output) out <= addr;
		else if (Enter != prev_enter) begin
			prev_enter <= Enter;
			out <= addr;
		end
	end
endmodule
