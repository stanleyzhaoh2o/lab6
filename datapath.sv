module datapath
(
		input logic Clk, Reset, LD_MDR, LD_MAR, LD_IR, LD_PC, LD_CC, LD_BEN,
		input logic GateMDR, GatePC, GateALU, GateMARMUX, MIO_EN,
		input logic [1:0] PCMUX,
		input logic [15:0] Data_from_SRAM, 
		output logic [15:0] IR, MAR,
		output logic [15:0] MDR, PC,
		output logic BEN
);

		logic [15:0] MDRval, BUS, PCplus1, PCval;
		logic N_in, Z_in, P_in;
		logic N_out, Z_out, P_out;
		
		//load to BUS
		BUS_MUX BUSnew (.d0(PC), .d1(MDR), .d2(/*ALU*/ 16'b0), .d3(/*MARMUX*/ 16'b0), .s({GatePC, GateMDR, GateALU, GateMARMUX}), .y(BUS));
		
		//BUS to MAR
		register MAR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .Data_in(BUS), .Data_out(MAR));
		
		//first choose from the BUS and M[MAR], then put it into MDR
		mux2 MDRnew (.d0(BUS), .d1(Data_from_SRAM), .s(MIO_EN), .y(MDRval));
		register MDR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .Data_in(MDRval), .Data_out(MDR));
		
		//MDR to IR
		assign PCplus1 = PC+1;
		register IR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .Data_in(BUS), .Data_out(IR));
		mux4 pcmux(.d0(PCplus1), .d1(16'b0), .d2(16'b0), .d3(16'b0), .s(PCMUX), .y(PCval));
		register PC_reg(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .Data_in(PCval), .Data_out(PC));
		
		NZP_reg nzp(.*);
		BEN_reg ben(.Clk(Clk), .N(N_out), .Z(Z_out), .P(P_out), .LD_BEN(LD_BEN), .IR_sub(IR[11:9]), .BEN(BEN));
		
		always_comb begin
			if (BUS[15]) begin
				N_in <= 1'b1;
				Z_in <= 1'b0;
				P_in <= 1'b0;
			end
			else begin
				case (BUS)
					16'b0:
						begin
							N_in <= 1'b0;
							Z_in <= 1'b1;
							P_in <= 1'b0;
						end
				default:
				begin
					N_in <= 1'b0;
					Z_in <= 1'b0;
					P_in <= 1'b1;
				end
				endcase
			end
		end
		
							
endmodule
