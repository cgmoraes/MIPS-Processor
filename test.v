module test
(	
  input clk, ctx, quantum, Halt,
  input [31:0] Address_out, Base_addr, 
  output reg [6:0] Hex0, Hex1, Hex2, Hex3, Hex4, Hex5, Hex6, Hex7
);


  initial begin
		Hex0 <= 7'b1111111;
		Hex1 <= 7'b1111111;
		Hex2 <= 7'b1111111;
		Hex3 <= 7'b1111111;
		Hex4 <= 7'b1111111;
		Hex5 <= 7'b1111111;
		Hex6 <= 7'b1111111;
		Hex7 <= 7'b1111111;
  end

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
  
  always @ (posedge clk or posedge Halt)
  begin
		if(Halt) begin
			if(ctx) begin
				Hex0 <= 7'b0100001;
				Hex1 <= 7'b0101011;
				Hex2 <= 7'b0000110;
				Hex3 <= 7'b1111111;
				Hex4 <= 7'b1111111;
				Hex5 <= 7'b1111111;
				Hex6 <= 7'b1111111;
				Hex7 <= 7'b1111111;
			end else if(!ctx) begin
				Hex0 <= 7'b0100001;
				Hex1 <= 7'b0101011;
				Hex2 <= 7'b0000110;
				Hex3 <= 7'b0111110;
				Hex4 <= 7'b0111110;
				Hex5 <= 7'b0111110;
				Hex6 <= 7'b0111110;
				Hex7 <= 7'b0111110;
			end
		end else begin
			BCD(Address_out%10, Hex0);
			BCD((Address_out%100)/10, Hex1);
			BCD((Address_out%1000)/100, Hex2);
			BCD(Base_addr%10, Hex3);
			BCD((Base_addr%100)/10, Hex4);
			BCD((Base_addr%1000)/100, Hex5);
			BCD({3'b000,quantum}, Hex6);
			BCD({3'b000,ctx}, Hex7);
		end
  end
  
endmodule