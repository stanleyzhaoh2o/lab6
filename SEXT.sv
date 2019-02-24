module SEXT_5 
(
input  logic [10:0] IN,
output logic [15:0] OUT
);

always_comb
	begin
		if (IN[10])
			OUT[15:11] = 5'b11111;
		else
			OUT[15:11] = 5'h0;
		OUT[10:0] = IN;
	end	
endmodule

module SEXT_7 
(
input  logic [8:0] IN,
output logic [15:0] OUT
);
		
always_comb
	begin
		if (IN[8])
			OUT[15:9] = 7'b1111111;
		else
			OUT[15:9] = 7'h0;
		OUT[8:0] = IN;
	end
endmodule

module SEXT_10 
(
input  logic [5:0] IN,
output logic [15:0] OUT
);
		
always_comb
	begin
		if (IN[5])
			OUT[15:6] = 10'b1111111111;
		else
			OUT[15:6] = 10'h0;
		OUT[5:0] = IN;
	end		
endmodule

module SEXT_11 
(
input  logic [4:0] IN,
output logic [15:0] OUT
);
		
always_comb
	begin
		if (IN[4])
			OUT[15:5] = 11'b11111111111;
		else
			OUT[15:5] = 11'h0;
		OUT[4:0] = IN;
	end		
endmodule
