module Timer(
    input clk,
    input setQuantum,            // Sinal para acionar a redefinição
	 input [31:0] Read_Data1,
    output reg [31:0] Time_quantum        // Sinaliza quando o Time_quantum se esgota
);


always @(negedge clk) begin
    if (setQuantum) Time_quantum <= Read_Data1-32'd1;
end

endmodule