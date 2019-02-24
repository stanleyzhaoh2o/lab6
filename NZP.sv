module NZP(
	input logic Clk,
	input logic N_in,
	input logic Z_in,
	input logic P_in,
	input logic LD_CC,
	output logic N_out,
	output logic Z_out,
	output logic P_out
);

always_ff @ (posedge Clk)
			begin
				if (LD_CC)
				begin
					N_out <= N_in;
					Z_out <= Z_in;
					P_out <= P_in;
				end
			end
endmodule
