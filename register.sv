module register
(
		input  logic Clk, Reset, Load, 
      input  logic [15:0] Data_in, 
      output logic [15:0] Data_out
);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_out <= 16'h0;
		 else if (Load)
			  Data_out <= Data_in;
    end
	 
endmodule
