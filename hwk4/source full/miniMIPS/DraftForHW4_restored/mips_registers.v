module mips_registers
( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	output reg [31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [2:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write, clk;
	wire not_zero, enable_write;
	
	or( not_zero, write_reg[0], write_reg[1], write_reg[2] );
	and(enable_write, not_zero, signal_reg_write );
	
	
	reg [31:0] registers [7:0];//8 registers of ours
		
		
	//Read always ON
	always @(*) 
	begin
		read_data_1 <= registers[read_reg_1];
		read_data_2 <= registers[read_reg_2];
	end	

	//this module use behavioral verilog
	//for register & data memory part, use files
	//register.mem or register.txt (file extension does not important)
	
	//--- continuos assignment --- 
	//output data;
	//assign data = registers[adress];
	//--- non-blocking assignment ---
	//register data;
	//always @(posedge clk) begin
	//data <= registers[adress]; end
	
	//write on negative edge clock, following mips convention
	always @(negedge clk) 
	begin
		//second check reg write signal and write
		if (enable_write)
			begin
			registers[write_reg] <= write_data;
			end
		end
endmodule