`define DELAY 50

module MiniMIPS_testbench ();

//reg [15:0] instruction_set [29:0];
reg [15:0] instruction;
reg clk;
wire [31:0]result;//, read_data_rs, read_data_rd_rt, immed_extend;
//wire [2:0] alu_ctr, rs, rt, rd, rd_rt_address;
MiniMIPS minimips(instruction, result, clk);// read_data_rs, read_data_rd_rt, alu_ctr, rs, rt, rd, rd_rt_address, immed_extend);

initial begin
$readmemb("data.txt", minimips.data_mem.memory);
$readmemb("registers.mem", minimips.regs.registers);
clk = 1'b1; //initial clock is 1
//you can give here, like below this
//instruction = 16'b0000010100001001;
//#`DELAY; // rs=$16 rt=$17 rd=$18 s2=s0+s1 		add  s2 s0 s1
//add $1, $2, $4    ---->      
instruction = 16'b0000010100001001;
#`DELAY;
instruction = 16'b0000011001101001;

#`DELAY;
instruction = 16'b0000110111101010;

#`DELAY;
instruction = 16'b0000101101101010;

#`DELAY;
instruction = 16'b0000111110101000;

#`DELAY;
//and $4, $2, $4
instruction = 16'b0000_010_100_100_000;

#`DELAY;
//xor $4, $3, $4
instruction = 16'b0000_011_100_100_011;

#`DELAY;
//xor $2, $7, $4
instruction = 16'b0000_111_100_010_011;

#`DELAY

//nor $6, $1, $2
instruction = 16'b0000_001_010_110_100;

#`DELAY
//nor $3, $6, $4
instruction = 16'b0000_110_100_011_100;

#`DELAY

//b0000_001_010_101_100
//or $5, $1, $2
instruction = 16'b0000_001_010_101_101;

#`DELAY
//or $7, $6, $5
instruction = 16'b0000_110_101_111_101;
//addi $7, $2, 011111
#`DELAY
instruction = 16'b0001_010_111_011_111;
//addi $6, $7, 000101
#`DELAY
instruction = 16'b0001_111_110_000_101;
//andi $6, $4, 1010
#`DELAY
instruction = 16'b0010_100_110_001_010;
//andi $1, $1, 0001
#`DELAY
instruction = 16'b0010_001_001_000_001;
#`DELAY

//ori $6, $4, 1010
instruction = 16'b0011_100_110_001_111;
#`DELAY

//ori $6, $4, 1010
instruction = 16'b0011_001_001_000_001;
#`DELAY

//nori $6, $4, 1111
instruction = 16'b0100_100_110_001_111;
#`DELAY

//nori $1, $1, 0001
instruction = 16'b0100_001_001_000_001;
#`DELAY

//slti $6, $4, 11111
instruction = 16'b0111_100_110_011_111;
#`DELAY

//slti $1, $1, 0000
instruction = 16'b0111_001_001_000_000;
#`DELAY



//sw $3, 0($0)
instruction = 16'b1001_000_011_000_000;
#`DELAY

//sw $7, 3($0) 

instruction = 16'b1001_000_111_000_011;
#`DELAY


//lw $2, 0($0) 
instruction = 16'b1000_000_010_000_000;
#`DELAY

//lw $1, 2($6)
instruction = 16'b1000_110_001_000_010;
#`DELAY


$writememb("data_output.mem", minimips.data_mem.memory);
$writememb("registers_output.mem", minimips.regs.registers);

begin
$monitor("time = %2d, clk=%1b, instruction =%15b, result_bin = %32b, result_dec=%2d          ", $time, clk, instruction, result, result);
end

$finish;

end
//or you can take instructions from file
//readmemb("filename", instruction_set);

//for memory file read & write using followings
//$readmemb("registers.mem", mipsMOdulename.registerModuleName.registers);
//$writememb("registers_outp.mem", mipsMOdulename.registerModuleName.registers);

//Continue for all instruction types 
//Must be least 15*2=30 control lines (There must be at least 2 tests for each instruction)
//You can change the inside of the register.mem file as desired.

//end of the running, output files must be created/updated (register file & data file)

	//define clock cycle
	always
		begin
			#25 clk = ~clk;
		end
//	initial begin
	//$monitor("time=%2d, res=%32b, a=%32b, b=%32b"
	         // ,$time, res, a, b)

//end

endmodule