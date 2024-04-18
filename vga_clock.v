module vga_clock
(
	input clk,
	output reg clk_out
);
	
	reg [0:0]  count = 0;
	
	always @(posedge clk) begin
    count <= count + 1'b1;
    clk_out <= count;
	end
	
endmodule