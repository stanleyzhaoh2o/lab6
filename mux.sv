module mux2
		# (parameter width = 16)
		(input logic [width - 1:0] d0, d1,
		input logic s,
		output logic [width - 1:0] y);
		
		always_comb begin
			case (s)
				1'b1:
					y = d1;
				1'b0:
					y = d0;
			endcase
		end
endmodule

module mux4
		# (parameter width = 16)
		(
		input logic [width - 1:0] d0, d1, d2, d3,
		input logic [1:0] s,
		output logic [width - 1:0] y
		);
		
		always_comb begin
			case(s)
				2'b00:
					y = d0;
				2'b01:
					y = d1;
				2'b10:
					y = d2;
				2'b11:
					y = d3;
			endcase
		end
endmodule

module BUS_MUX
		# (parameter width = 16)
		(input logic [width - 1:0] d0, d1, d2, d3,
		input logic [3:0] s,
		output logic [width - 1:0] y);

		always_comb begin
			case(s)
				4'b1000:
					y = d0;
				4'b0100:
					y = d1;
				4'b0010:
					y = d2;
				4'b0001:
					y = d3;
			endcase
		end
endmodule
