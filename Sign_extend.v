module Sign_extend
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=16)
(
 input [(ADDR_WIDTH-1):0] immediate,
 input Jump, MemRead, MemWrite,
 input [31:0] mem_addr,
 output reg [(DATA_WIDTH-1):0] addr
);

 always @(immediate)
 begin
  
  if(immediate[(ADDR_WIDTH-1)]==1) 
	addr[(DATA_WIDTH-1):ADDR_WIDTH] = 16'b1111111111111111;
  else  
   addr[(DATA_WIDTH-1):ADDR_WIDTH] = 16'b0000000000000000;
  
  addr[(ADDR_WIDTH-1):0] = immediate[(ADDR_WIDTH-1):0];

  if(MemRead || MemWrite) addr = addr+mem_addr;
 end
endmodule