module testbench();

timeunit 10ns;
timeprecision 1ns;

//Inputs
logic[15:0] S = 16'b0;
logic Clk = 0;
logic Reset,Run, Continue;
//Outputs
logic[15:0] IR, PC, MAR, MDR;
wire [15:0] Data;
logic CE, UB, LB, OE, WE;
logic[19:0] ADDR;
logic[19:0] testmemADDR;
logic[15:0] D2CPU;
logic[15:0] BUS;
logic LD_MDR;
logic[15:0] DFromSRAM;
logic[11:0] LED;

logic[2:0] SR1;
logic[15:0] SR1_OUT;
logic BEN, LD_BEN, BEN_next;
logic[2:0] NZP;
logic tempCheck;

logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

lab6_toplevel tp( .S, .Clk, .Reset, .Run, .Continue,
                      .LED, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .HEX6, .HEX7,
                      .CE, .UB, .LB, .OE, .WE,
                      .ADDR, .PC,
                      .Data);
logic [15:0] M2IOMDR;
logic [15:0] M2IOMDR_HexData;
logic [2:0] DR;
logic [15:0] LDREG;


always @ *
begin:INITERAL_SIG_MONITOR
IR = tp.my_slc.d0.IR;
//PC = tp.my_slc.d0.PCout;
MAR = tp.my_slc.d0.MAR;
MDR = tp.my_slc.d0.MDR;
//SR1 = tp.my_slc.d0.regFile0.SR1addr;
//SR1_OUT = tp.my_slc.d0.SR1OUT;
//BEN = tp.my_slc.BEN;
//NZP = tp.my_slc.d0.br0.NZP;
//LD_BEN = tp.my_slc.d0.LD_BEN;
//BEN_next = tp.my_slc.d0.br0.BEN_next;
//M2IOMDR = tp.my_slc.memory_subsystem.Data_from_CPU;
//M2IOMDR_HexData = tp.my_slc.memory_subsystem.hex_data; 
//DR = tp.my_slc.d0.regFile0.DR;
//LDREG = tp.my_slc.d0.regFile0.LDREG;


/*
testmemADDR = my_slc3.memory_subsystem.ADDR;
D2CPU = my_slc3.memory_subsystem.Data_to_CPU;
*/
//BUS = tp.my_slc.d0.BUS;
/*LD_MDR = my_slc3.d0.LD_MDR;
DFromSRAM = my_slc3.Data_from_SRAM;
*/
end


always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end
initial begin : CLOCK_INITIALIZATION
Clk = 0;
end 
initial begin: TEST_VECTORS
Reset = 0;
Run = 1;
Continue = 1;
S = 16'd0;

#5 Reset = 1;
Run = 0;
S = 16'h14;
#3  Run = 1;
Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;
#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#4 Continue = 0;

#4 Continue = 1;

#5 Continue = ~Continue;

#5 Continue = ~Continue;

#5 Continue = ~Continue;

#5 Continue = ~Continue;

#5 Continue = ~Continue;

#5 Continue = ~Continue;

#5 Continue = ~Continue;
end

endmodule

