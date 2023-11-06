module PC
#(parameter ADDR_WIDTH=5)
(
	input clk, reset, ctx, Enter, Input, Output, interruptionProcess,
	input [1:0] Halt,
	input [2**ADDR_WIDTH-1:0] Read_Data2, Address_4, addr, Time_quantum, 
	output reg quantum,  
	output reg [ADDR_WIDTH-1:0] r31, r28,
	output reg [2**ADDR_WIDTH-1:0] Base_addr, mem_addr, Last_addr, out
);
	
	reg prev_enter = 0;
	reg [31:0] counter;
	
	initial begin
		counter <= 32'd1;
	   Base_addr <= 32'd0;
	   mem_addr <= 32'd0;
		Last_addr <= 32'd0;
		r31 <= 5'b01111;
		r28 <= 5'b01100;
  end

	always @ (posedge clk or posedge reset)
	begin
		if (reset) begin
			out <= 0;
			prev_enter <= 0;
			counter <= 32'd1;
         quantum <= 0;
			Base_addr <= 32'd0;
			mem_addr <= 32'd0;
			Last_addr <= 32'd0;
			r31 <= 5'b01111;
			r28 <= 5'b01100;
		end else if (quantum || Halt == 2'b01) begin
			if(!Input && !Output) begin
				counter <= 32'd1;
            quantum <= 0;
				out <= Last_addr;
				Last_addr <= (Halt == 2'b01) ? 32'd0:addr;
				Base_addr <= 32'd0;
				mem_addr <= 32'd0;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (Enter != prev_enter) begin
				counter <= 32'd1;
            quantum <= 0;
				prev_enter <= Enter;
				out <= Last_addr;
				Last_addr <= (Halt == 2'b01) ? 32'd0:addr;
				Base_addr <= 32'd0;
				mem_addr <= 32'd0;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end
		end else if (interruptionProcess) begin
			if(!Input && !Output) begin
				counter <= 32'd1;
            quantum <= 0;
				out <= addr;
            Last_addr <= Address_4;
				Base_addr <= Read_Data2 << 2;
				mem_addr <= Read_Data2+32'd16;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (Enter != prev_enter) begin
				counter <= 32'd1;
            quantum <= 0;
				prev_enter <= Enter;
				out <= addr;
            Last_addr <= Address_4;
				Base_addr <= Read_Data2 << 2;
				mem_addr <= Read_Data2+32'd16;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end
		end else if(!ctx && !quantum && !interruptionProcess) begin
			if(!Input && !Output && counter < Time_quantum) begin
				counter <= counter + 32'd1;
            quantum <= 0;
				out <= addr;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (Enter != prev_enter && counter < Time_quantum) begin
				counter <= counter + 32'd1;
            quantum <= 0;
				prev_enter <= Enter;
				out <= addr;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (!Input && !Output && counter >= Time_quantum) begin
				counter <= 32'd1;
            quantum <= 1;
				out <= addr;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (Enter != prev_enter && counter >= Time_quantum) begin
				counter <= 32'd1;
            quantum <= 1;
				out <= addr;
				prev_enter <= Enter;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end
		end else begin
			if(!Input && !Output) begin
				counter <= 32'd1;
            quantum <= 0;
				out <= addr;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end else if (Enter != prev_enter) begin
				counter <= 32'd1;
            quantum <= 0;
				prev_enter <= Enter;
				out <= addr;
				r31 <= {!ctx, 4'b1111};
				r28 <= {!ctx, 4'b1100};
			end
		end
	end
endmodule
