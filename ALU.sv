module ALU 
(
input  logic [15:0] A, B,
input  logic [1:0]  ALUK,
output logic [15:0] OUT
);
				
always_comb
	begin
		case (ALUK)		
			2'b00:
				OUT = A + B;// add
			2'b01:
				OUT = A & B;// and
			2'b10:
				OUT = ~A;	// not A
			2'b11:
				OUT = A;		// A
		endcase
	end	
endmodule
