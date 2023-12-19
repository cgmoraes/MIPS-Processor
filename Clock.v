module Clock
(
	input clk, reset, ctx, 
	input [1:0] Halt, freq,
	output reg clk_out
);

	initial
	begin
		clk_out <= 1;
	end
	
	integer count = 0;
	integer N;
	
	always @ (negedge clk)
	begin
	 case(freq)
		2'b01: N <= 25000000;
		2'b10: N <= 2500000;
		2'b11: N <= 1;
	 default: N <= 2500;
	 endcase
	 
	 if (reset) 
	 begin
		count <= 0;
		clk_out <= 0;
	 end
	 else if(Halt < 2'b10 || !clk_out)
	 begin
		 if (count < N)
		 begin
			count <= count + 1;
		 end
		 else 
		 begin
			count <= 0;
			clk_out <= ~clk_out;
		 end
	 end
	end
	
endmodule