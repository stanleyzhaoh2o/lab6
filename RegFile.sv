module Reg_File
(
		input logic Clk,
		input logic Reset,
		input logic LD_Reg,
		input logic [2:0] SR1_in,
		input logic [2:0] DR_in,
		input logic [2:0] SR2,
		input logic [15:0] In,
		output logic [15:0] SR1_out,
		output logic [15:0] SR2_out
);

logic [7:0][15:0] Reg_Array;

always_ff @ (posedge Clk)
		begin
			if (~Reset)
			begin
				Reg_Array[0] <= 16'h0;
				Reg_Array[1] <= 16'h0;
				Reg_Array[2] <= 16'h0;
				Reg_Array[3] <= 16'h0;
				Reg_Array[4] <= 16'h0;
				Reg_Array[5] <= 16'h0;
				Reg_Array[6] <= 16'h0;
				Reg_Array[7] <= 16'h0;
			end
			else if (LD_Reg)
			begin
					case (DR_in)
					3'b000:
					begin
						Reg_Array[0] <= In;
					end
					3'b001:
					begin
						Reg_Array[1] <= In;
					end
					3'b010:
					begin
						Reg_Array[2] <= In;
					end
					3'b011:
					begin
						Reg_Array[3] <= In;
					end
					3'b100:
					begin
						Reg_Array[4] <= In;
					end
					3'b101:
					begin
						Reg_Array[5] <= In;
					end
					3'b110:
					begin
						Reg_Array[6] <= In;
					end
					3'b111:
					begin
						Reg_Array[7] <= In;
					end
					default:
					begin
					end
					endcase
			end
			end
			
			always_comb
			begin
					case (SR1_in)
					3'b000:
					begin
						SR1_out <= Reg_Array[0];
					end
					3'b001:
					begin 
						SR1_out <= Reg_Array[1];
					end
					3'b010:
					begin
						SR1_out <= Reg_Array[2];
					end
					3'b011:
					begin
						SR1_out <= Reg_Array[3];
					end
					3'b100:
					begin
						SR1_out <= Reg_Array[4];
					end
					3'b101:
					begin
						SR1_out <= Reg_Array[5];
					end
					3'b110:
					begin
						SR1_out <= Reg_Array[6];
					end
					3'b111:
					begin
						SR1_out <= Reg_Array[7];
					end
					default:
					begin
					end
					endcase
					
					case (SR2)
					3'b000:
					begin
						SR2_out <= Reg_Array[0];
					end
					3'b001:
					begin
						SR2_out <= Reg_Array[1];
					end
					3'b010:
					begin
						SR2_out <= Reg_Array[2];
					end
					3'b011:
					begin
						SR2_out <= Reg_Array[3];
					end
					3'b100:
					begin
						SR2_out <= Reg_Array[4];
					end
					3'b101:
					begin
						SR2_out <= Reg_Array[5];
					end
					3'b110:
					begin
						SR2_out <= Reg_Array[6];
					end
					3'b111:
					begin
						SR2_out <= Reg_Array[7];
					end
					default:
					begin
					end
					endcase
				
			end
endmodule
