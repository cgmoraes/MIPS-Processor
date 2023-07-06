module ALU
#(parameter CONTROL_WIDTH=4, parameter DATA_WIDTH=32)
( 
 input [(CONTROL_WIDTH-1):0] ALUCtrl, 
 input [4:0] Shamt,
 input [(DATA_WIDTH-1):0] A, B,
 output Zero,
 output reg [(DATA_WIDTH-1):0] ALU_result
);
 
 always @ (A, B, Shamt, ALUCtrl)
 begin
    case(ALUCtrl)
	  4'd0: ALU_result <= A&B;           //and
	  4'd1: ALU_result <= A|B;           //or
	  4'd2: ALU_result <= A+B;           //add
	  4'd3: ALU_result <= A-B;           //sub
	  4'd4: ALU_result <= (A<B) ? 1:0;   //blt, slt
	  4'd5: ALU_result <= (A>B) ? 1:0;   //bgt, sgt
	  4'd6: ALU_result <= ~A;            //not
	  4'd7: ALU_result <= A*B;           //mult
	  4'd8: ALU_result <= A/B;           //div
	  4'd9: ALU_result <= A << Shamt;    //sll
	  4'd10: ALU_result <= A >> Shamt;   //srl
	  4'd11: ALU_result <= (A<=B) ? 1:0; //slet
	  4'd12: ALU_result <= (A>=B) ? 1:0; //sget
	  4'd13: ALU_result <= (A==B) ? 1:0; //set
	  4'd14: ALU_result <= (A!=B) ? 1:0; //sdt
	 default: ALU_result <= 0;
	 endcase
 end
 
 assign Zero = (ALU_result==0);
endmodule