module IO
(	
  input clk, reset, Input, Output, Halt, Enter,
  input [9:0] sw, 
  input [31:0] output_num, 
  output [31:0] Input_Data,
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
  
  always @ (posedge clk or posedge reset or posedge Halt)
  begin
	if(reset) begin
		Hex0 <= 7'b0111111;
		Hex1 <= 7'b0111111;
		Hex2 <= 7'b0111111;
		Hex3 <= 7'b0111111;
		Hex4 <= 7'b0111111;
		Hex5 <= 7'b0111111;
		Hex6 <= 7'b0111111;
		Hex7 <= 7'b0111111;
	end else if(Halt) begin
		Hex0 <= 7'b0100001;
		Hex1 <= 7'b0101011;
		Hex2 <= 7'b0000110;
		Hex3 <= 7'b1111111;
		Hex4 <= 7'b1111111;
		Hex5 <= 7'b1111111;
		Hex6 <= 7'b1111111;
		Hex7 <= 7'b1111111;
	end else if(Output && !Input) begin
		BCD(output_num%10, Hex0);
		BCD((output_num%100)/10, Hex1);
		BCD((output_num%1000)/100, Hex2);
		BCD((output_num%10000)/1000, Hex3);
		BCD((output_num%100000)/10000, Hex4);
		BCD((output_num%1000000)/100000, Hex5);
		Hex6 <= 7'b1100011;
		Hex7 <= 7'b1000000;
	end else if(!Output && Input)begin
		BCD(Input_Data%10, Hex0);
		BCD((Input_Data%100)/10, Hex1);
		BCD((Input_Data%1000)/100, Hex2);
		BCD((Input_Data%10000)/1000, Hex3);
		BCD((Input_Data%100000)/10000, Hex4);
		BCD((Input_Data%1000000)/100000, Hex5);
		Hex6 <= 7'b0101011;
		Hex7 <= 7'b1111001;
	end else begin
		Hex0 <= 7'b0111111;
		Hex1 <= 7'b0111111;
		Hex2 <= 7'b0111111;
		Hex3 <= 7'b0111111;
		Hex4 <= 7'b0111111;
		Hex5 <= 7'b0111111;
		Hex6 <= 7'b0111111;
		Hex7 <= 7'b1111111;
	end
  end
  
  assign Input_Data = {22'b0,sw};
  
  
endmodule