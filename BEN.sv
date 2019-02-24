module BEN_reg
(
		input logic Clk,
		input logic N,
		input logic Z,
		input logic P,
		input logic LD_BEN,
		input logic [2:0] IR_sub,
		output logic BEN
);

always_ff @ (posedge Clk)
		begin 
			if (LD_BEN)
				BEN <= (IR_sub[2]&N)|(IR_sub[1]&Z)|(IR_sub[0]&P);
		end
endmodule
		
