`define DELAY 20
module alu_1bit_testbench();
	//module alu_1bit(res, c_i_plus_1, alu_op, a, b, c_i, less_i);
	reg a, b, c_i, less_i;
	reg [2:0] alu_op;
	wire res, c_i_plus_1;
	
	alu_1bit alu1bit(res,c_i_plus_1,alu_op, a, b, c_i, less_i);
		
	initial begin
	//add
	alu_op = 3'b000; a =1'b1; b = 1'b1; c_i = 1'b1;less_i = 1'b0;
	#`DELAY;
	//xor
	alu_op = 3'b001; a =1'b1; b = 1'b0; c_i = 1'b0;less_i = 1'b0;
	#`DELAY;
	//sub
	alu_op = 3'b010; a =1'b1; b = 1'b0; c_i = 1'b1;less_i = 1'b0;
	#`DELAY;
	//mult
	alu_op = 3'b011; a =1'b1; b = 1'b0; c_i = 1'b0;less_i = 1'b0;
	#`DELAY;
	//slt
	alu_op = 3'b100; a =1'b1; b = 1'b0; c_i = 1'b1;less_i = 1'b0;
	#`DELAY;
	//nor
	alu_op = 3'b101; a =1'b1; b = 1'b0; c_i = 1'b0;less_i = 1'b0;
	#`DELAY;
	//and
	alu_op = 3'b110; a =1'b1; b = 1'b0; c_i = 1'b0;less_i = 1'b0;
	#`DELAY;
	//or
	alu_op = 3'b111; a =1'b1; b = 1'b0; c_i = 1'b0;less_i = 1'b0;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,a=%1b,b=%1b,c_i=%1b,less_i=%1b, alu_op2=%1b,alu_op1=%1b,alu_op0=%1b,c_i_plus_1=%1b,res=%1b"
	          ,$time, a, b, c_i, less_i ,alu_op[2], alu_op[1], alu_op[0], c_i_plus_1, res);
	end
endmodule