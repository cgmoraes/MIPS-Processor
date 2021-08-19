module Clock
#(parameter N = 50000000)
(
	input clk, reset,
	output reg clk_out
);

	reg [31:0] count;
	
	always @ (posedge clk or negedge reset)
	begin
	 if (!reset) 
	 begin
		count <= 32'b0;
		clk_out <= 0;
	 end
    else if (count == N - 1)
	 begin
		count <= 32'b0;
		clk_out <= ~clk_out;
	 end
    else 
	 begin
		count <= count + 1;
	 end
	end
	
endmodule