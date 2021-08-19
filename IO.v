module IO
(	
  input clk, reset, MemtoReg,
  input [31:0] ALU_result, RAM_Read_Data,
  output reg [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7
);

  task BCD;
	input [3:0] value;
	output [6:0] display;
	case (value)
		0: display <= 7'b1000000;
		1: display <= 7'b1111001;
		2: display <= 7'b0100100;
		3: display <= 7'b0110000;
		4: display <= 7'b0011001;
		5: display <= 7'b0010010;
		6: display <= 7'b0000010;
		7: display <= 7'b1111000;
		8: display <= 7'b0000000;
		9: display <= 7'b0010000;
		10: display <= 7'b0001000;
		11: display <= 7'b0000011;
		12: display <= 7'b1000110;
		13: display <= 7'b0100001;
		14: display <= 7'b0000110;
		15: display <= 7'b0001110;
		default: display <= 7'b1111111;
	endcase
  endtask
  
  always @ (posedge clk or negedge reset)
  begin
	if(!reset)
	begin
		Hex0 <= 7'b1000000;
		Hex1 <= 7'b1000000;
		Hex2 <= 7'b1000000;
		Hex3 <= 7'b1000000;
		Hex4 <= 7'b1000000;
		Hex5 <= 7'b1000000;
		Hex6 <= 7'b1000000;
		Hex7 <= 7'b1000000;
	end
	else if(MemtoReg)
	begin
		BCD(RAM_Read_Data%10, Hex0);
		BCD((RAM_Read_Data%100)/10, Hex1);
		BCD((RAM_Read_Data%1000)/100, Hex2);
		BCD((RAM_Read_Data%10000)/1000, Hex3);
		BCD((RAM_Read_Data%100000)/10000, Hex4);
		BCD((RAM_Read_Data%1000000)/100000, Hex5);
		BCD((RAM_Read_Data%10000000)/1000000, Hex6);
		BCD((RAM_Read_Data%100000000)/10000000, Hex7);
	end
	else 
	begin
		BCD(ALU_result%10, Hex0);
		BCD((ALU_result%100)/10, Hex1);
		BCD((ALU_result%1000)/100, Hex2);
		BCD((ALU_result%10000)/1000, Hex3);
		BCD((ALU_result%100000)/10000, Hex4);
		BCD((ALU_result%1000000)/100000, Hex5);
		BCD((ALU_result%10000000)/1000000, Hex6);
		BCD((ALU_result%100000000)/10000000, Hex7);
	end
  end
endmodule