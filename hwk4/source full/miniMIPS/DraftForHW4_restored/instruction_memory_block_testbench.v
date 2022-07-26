module instruction_memory_block_testbench();
		
	wire [15:0] instruction;
	reg [5:0] read_adress;
	reg clk;

	instruction_memory_block instr_memory_block(instruction,read_adress,clk);
								

	initial begin
	//read file
	$readmemb("instruction_data.txt", instr_memory_block.instr_memory);
	clk = 1'b1; //initial clock is 1
	
	read_adress = 6'b000_000; //0st adress
	#20;
	clk = ~clk;
	#20;
	clk = ~clk;
	
	read_adress = 6'b000_111; //7th adress
	#20;
	clk = ~clk; //negatif edge
	#20;
	clk = ~clk; //pozitif edge
	
	read_adress = 6'b111_111; //last address
	#20;
	clk = ~clk;
	end
	initial begin
	$monitor("time=%2d, read_adress=%2d,  clk=%1b,  instruction=%16b "
	         ,$time,read_adress,clk,instruction);
	end
endmodule