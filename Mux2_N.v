module Mux2_N 
#(parameter N=32)
(
 input [N-1:0] A, B, C,
 input [1:0] control,
 output [N-1:0] mux_out
);

 assign mux_out = (control==2'b00) ? A: (control==2'b01) ? B:C;
endmodule
