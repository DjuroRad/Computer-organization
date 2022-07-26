module mips_registers_testbench();
	wire [31:0] read_data1,read_data2;
	reg [31:0] write_data;
	reg [2:0] read_reg1,read_reg2,write_reg;
	reg reg_write,clk;
	
	//( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	mips_registers my_reg(read_data1,read_data2, write_data, read_reg1,read_reg2, write_reg, reg_write, clk);
								

	initial begin
	//read file
	//for memory file read & write using followings
	//$readmemb("dsf.mem", mipsMOdulename.registerModuleName.registers);
	//$writememb("registers_outp.mem", mipsMOdulename.registerModuleName.registers);
	$readmemb("registers.mem", my_reg.registers);
	clk = 1'b1; //initial clock is 1
	//only regwrite signal is 1
	write_data = 32'b11111111111001111111000011111111; 
	read_reg1 = 3'b001;//1
	read_reg2 = 3'b111;//7
	write_reg = 3'b011;// write this data to register 3
	reg_write = 1'b1;
	
	#20;
	clk = ~clk; 
	#20;
	clk = ~clk; 
	
	write_data = 32'b000000000000000000000000000011111; 
	read_reg1 = 3'b011;//read data written to register 3
	read_reg2 = 3'b110;//read data form reg  6
	write_reg = 3'b000;//try to write it to 0, should not be written in this register
	reg_write = 1'b1;
	
	#20;
	clk = ~clk;
	#20;
	clk = ~clk;
	
	//only enable signal 1
	// both write signals are 0
	write_data = 32'b00000000000000000000001100001111; 
	read_reg1 = 3'b000;//read data from register 0, should be 0 and 31 we tried to write during the previous cycle should not be written
	read_reg2 = 3'b101;//read data from 5th register
	write_reg = 3'b001;//try to write it here, should not be written in here since reg_write is not enabled of course
	reg_write = 1'b0;
	
	#20;
	clk = ~clk;
	#20;
	clk = ~clk;
	
	// both write signals are 0
	write_data = 32'b00000000000000000000000000000000; 
	read_reg1 = 3'b001;//check that the data has hot been written while the reg_write was 0
	read_reg2 = 3'b000;//1
	write_reg = 3'b001;//write 0 to first register, should be seen during the last cycle on the negative edge
	reg_write = 1'b1;
	
	#20;
	clk = ~clk;
	#20;
	clk = ~clk;
	$writememb("C:\altera\13.1\workspace\miniMIPS\DraftForHW4_restored\simulation\modelsim\registers_outp.mem", my_reg.registers);

	//$writememb("register_data_out.txt",my_reg.registers);
	end
	initial begin
	$monitor("time=%2d, read_reg1=%2d,  read_reg2=%2d,  write_reg=%2d,  write_data=%2d,  reg_write=%1b,   read_data1=%2d,   read_data2=%2d ,  clk=%2d "
	         ,$time,  read_reg1, read_reg2, write_reg, write_data, reg_write, read_data1, read_data2, clk, );
	end
endmodule