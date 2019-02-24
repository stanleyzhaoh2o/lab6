module datapath
(
		input logic Clk, Reset, LD_MDR, LD_MAR, LD_IR, LD_PC,
		input logic GateMDR, GatePC, GateALU, GateMARMUX, MIO_EN,
		input logic [1:0] PCMUX,
		input logic [15:0] Data_from_SRAM, 
		output logic [15:0] IR, MAR,
		output logic [15:0] MDR, PC
);

		logic [15:0] MDRval, BUS, PCplus1, PCval;
		
		//load to BUS
		BUS_MUX BUSnew (.d0(PC), .d1(MDR), .d2(/*ALU*/ 16'b0), .d3(/*MARMUX*/ 16'b0), .s({GatePC, GateMDR, GateALU, GateMARMUX}), .y(BUS));
		
		//BUS to MAR
		register MAR1(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .Data_in(BUS), .Data_out(MAR));
		
		//first choose from the BUS and M[MAR], then put it into MDR
		mux2 MDRnew (.d0(BUS), .d1(Data_from_SRAM), .s(MIO_EN), .y(MDRval));
		register MDR1(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .Data_in(MDRval), .Data_out(MDR));
		
		//MDR to IR
		assign PCplus1 = PC+1;
		register IR1(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .Data_in(BUS), .Data_out(IR));
		mux4 pcmux(.d0(PCplus1), .d1(16'b0), .d2(16'b0), .d3(16'b0), .s(PCMUX), .y(PCval));
		register PC1(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .Data_in(PCval), .Data_out(PC));

endmodule
