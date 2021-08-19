module Add
#(parameter DATA_WIDTH=32)
(
 input [(DATA_WIDTH-1):0] addr1, addr2,
 output [(DATA_WIDTH-1):0] out
);

 assign out = addr1 + addr2;
endmodule
