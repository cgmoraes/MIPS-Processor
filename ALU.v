module ALU
#(parameter CONTROL_WIDTH=4, parameter DATA_WIDTH=32)
( 
 input [(CONTROL_WIDTH-1):0] ALUCtrl, 
 input [4:0] Shamt,
 input [(DATA_WIDTH-1):0] A, B,
 output Zero,
 output reg [(DATA_WIDTH-1):0] ALU_result
);
 reg signed [(DATA_WIDTH*2)-1:0] HiLo;
 
 initial
  begin
   HiLo = 0;
  end
 
 always @ (A, B, ALUCtrl)
 begin
    case(ALUCtrl)
	  4'd0: ALU_result <= A&B;           //and
	  4'd1: ALU_result <= A|B;           //or
	  4'd2: ALU_result <= A+B;           //add
	  4'd3: ALU_result <= A-B;           //sub
	  4'd4: ALU_result <= A<B ? 1:0;     //blt
	  4'd5: ALU_result <= A>B ? 1:0;     //bgt
	  4'd6: ALU_result <= ~A;            //not
	  4'd7: HiLo <= A*B;                 //mult
	  4'd9: ALU_result <= A << Shamt;    //sll
	  4'd10: ALU_result <= A >> Shamt;   //srl
	  4'd8:                              //div
	  begin
	   HiLo[31:0] <= A / B;
		HiLo[63:32] <= A % B;
	  end
	 default: ALU_result <= 0;
	 endcase
 end
 
 assign Zero = (ALU_result==0);
endmodule