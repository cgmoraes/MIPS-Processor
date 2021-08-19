module Mux_N 
#(parameter N=32)
(
 input [N-1:0] A, B,
 input control,
 output [N-1:0] mux_out
);

 assign mux_out = (control==0) ? A:B;
endmodule
