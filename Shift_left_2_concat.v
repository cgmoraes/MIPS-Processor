module Shift_left_2_concat
(
 input [25:0] addr1,
 input [3:0] addr2,
 input [31:0] Base_addr,
 output reg [31:0] out
);

 always @(addr1,addr2, Base_addr)
 begin
  out <= (addr1 << 2) + Base_addr;
  out[31:28] <= addr2[3:0];
 end
endmodule
