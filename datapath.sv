module datapath
(
		input logic Clk, Reset, LD_MDR, LD_MAR, LD_IR, LD_PC, LD_CC, LD_BEN, LD_REG, LD_LED, 
		input logic GateMDR, GatePC, GateALU, GateMARMUX, MIO_EN, DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
		input logic [1:0] PCMUX, ADDR2MUX, ALUK,
		input logic [15:0] MDR_In, 
		output logic [15:0] IR, MAR, MDR,
		output logic [11:0] LED, 
		output logic BEN
);

		logic [15:0] PC, MDRval, BUS, PCplus1, PCval, SR1val, SR2val;
		logic N_in, Z_in, P_in;
		logic N_out, Z_out, P_out;
		logic [15:0] ALUval, MARMUXval,ADDR2MUXval, ADDR1MUXval, SR2MUXval;
		logic [15:0] SEXT5, SEXT7, SEXT10, SEXT11;
		logic [2:0] SR1_IN, SR2_IN, DR_IN;

		SEXT_5 sext5(.IN(IR[10:0]), .OUT(SEXT5));
		SEXT_7 sext7(.IN(IR[8:0]), .OUT(SEXT7));
		SEXT_10 sext10(.IN(IR[5:0]), .OUT(SEXT10));
		SEXT_11 sext11(.IN(IR[4:0]), .OUT(SEXT11));
		//load to BUS
		BUS_MUX BUSnew (.d0(PC), .d1(MDR), .d2(ALUval), .d3(MARMUXval), .s({GatePC, GateMDR, GateALU, GateMARMUX}), .y(BUS));
		
		//BUS to MAR
		register MAR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .Data_in(BUS), .Data_out(MAR));
		
		//first choose from the BUS and M[MAR], then put it into MDR
		mux2 mdrMUX(.d0(BUS), .d1(MDR_In), .s(MIO_EN), .y(MDRval));
		register MDR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .Data_in(MDRval), .Data_out(MDR));
		
		//MDR to IR
		assign PCplus1 = PC+1;
		register IR_reg(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .Data_in(BUS), .Data_out(IR));
		mux4 pcmux(.d0(PCplus1), .d1(MARMUXval), .d2(BUS), .d3(16'b0), .s(PCMUX), .y(PCval));
		register PC_reg(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .Data_in(PCval), .Data_out(PC));
		
		//assign he value of ADDR2MUXval and ADDR1MUXval
		mux4 addr2mux(.d0(16'h0), .d1(SEXT10), .d2(SEXT7), .d3(SEXT5), .s(ADDR2MUX), .y(ADDR2MUXval));
		mux2 addr1mux(.d0(PC), .d1(SR1val), .s(ADDR1MUX), .y(ADDR1MUXval));
		ALU adder (.A(ADDR1MUXval), .B(ADDR2MUXval), .ALUK(2'b00), .OUT(MARMUXval));
		
		//register file
		mux2 sr1_in(.d0(IR[8:6]), .d1(IR[11:9]), .s(SR1MUX), .y(SR1_IN));
		assign SR2_IN = IR[2:0];
		mux2 dr_in(.d0(IR[11:9]), .d1(3'b111), .s(DRMUX), .y(DR_IN));
		Reg_File regfile(.*, .LD_Reg(LD_REG), .SR1_in(SR1_IN), .SR2(SR2_IN), .DR_in(DR_IN), .In(BUS), .SR1_out(SR1val), .SR2_out(SR2val));
		
		//SR2MUX and ALU
		mux2 sr2_mux(.d0(SR2val), .d1(SEXT11), .s(SR2MUX), .y(SR2MUXval));
		ALU alu(.A(SR1val), .B(SR2MUXval), .ALUK(ALUK), .OUT(ALUval));
	
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
		
		//load LED
		always_ff @ (posedge Clk) begin
			if (LD_LED)
				LED <= IR[11:0];
			else	
				LED <= 12'h0;
		end
							
endmodule
