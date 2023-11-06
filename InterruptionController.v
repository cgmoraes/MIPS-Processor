module InterruptionController(
	 input clk, reset, quantum, interruptionProcess,
	 input [1:0] Halt,
	 output reg ctx
);
	 initial begin
		ctx <= 1;
	 end

    always @(negedge clk or posedge reset)
    begin
        if(reset) ctx <= 1;
		  else if(quantum || Halt == 2'b01) ctx <= 1;
        else if(interruptionProcess) ctx <= 0;
    end

endmodule