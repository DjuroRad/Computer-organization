`define DELAY 20
module instruction_splitter_testbench();
	
	wire [2:0] funct;
	wire[5:0] immed;
	wire [2:0] rs, rt, rd;
	wire [3:0] opcode;
	reg [15:0] instruction;
	//(opcode, rs, rt, rd, immed, funct, instruction);
	instruction_splitter is(opcode, rs, rt, rd, immed, funct, instruction);
		
	initial begin
	//add
	instruction =16'b0000_0101_0000_1001;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,a=%16b"
	          ,$time, instruction);
	end
endmodule