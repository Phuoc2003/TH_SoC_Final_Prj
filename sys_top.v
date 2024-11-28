module sys_top(
					input CLOCK_50,
					input [0:0] KEY,
					inout FPGA_I2C_SCLK,
					inout FPGA_I2C_SDAT);

	wire scl_in;
	wire sda_in;
	wire scl_oe;
	wire sda_oe;
	
	assign scl_in = FPGA_I2C_SCLK;
	assign sda_in = FPGA_I2C_SDAT;
	assign FPGA_I2C_SCLK = scl_oe ? 1'b0 : 1'bz;
	assign FPGA_I2C_SDAT = sda_oe ? 1'b0 : 1'bz;
					
	system NIOS_SYSTEM(
							 .clk_clk(CLOCK_50),                 //              clk.clk
							 .reset_reset_n(KEY[0]),    
							 .i2c_0_i2c_serial_sda_in(sda_in), // i2c_0_i2c_serial.sda_in
							 .i2c_0_i2c_serial_scl_in(scl_in), //                 .scl_in
							 .i2c_0_i2c_serial_sda_oe(sda_oe), //                 .sda_oe
							 .i2c_0_i2c_serial_scl_oe(scl_oe) //                 .scl_oe
							 );
		 
endmodule
