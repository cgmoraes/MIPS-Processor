module Shift_left_2
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=1)
(
 input [(DATA_WIDTH-1):0] addr1,
 input [(ADDR_WIDTH-1):0] addr2,
 output reg [31:0] out
);

 always @(addr1,addr2)
 begin
  out <= addr1 << 2;
  if(!ADDR_WIDTH) out[31:(32-ADDR_WIDTH)] <= addr2[(ADDR_WIDTH-1):0];
 end
endmodule
