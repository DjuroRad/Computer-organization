`define DELAY 20
module alu_control_unit_testbench();
	reg [2:0] func, alu_op;
	wire [2:0]alu_ctr;
	
	
	alu_control_unit mt_control_unit(alu_ctr, func, alu_op);
	initial begin
	func = 3'b000; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b001; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b010; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b011; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b100; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b101; alu_op = 3'b000; 
	#`DELAY;
	func = 3'b000; alu_op = 3'b011; 
	#`DELAY;
	func = 3'b000; alu_op = 3'b100;
	#`DELAY;
	func = 3'b000; alu_op = 3'b101;
	#`DELAY;
	func = 3'b000; alu_op = 3'b110;
	#`DELAY;
	func = 3'b000; alu_op = 3'b010;
	#`DELAY;
	func = 3'b000; alu_op = 3'b111;
	#`DELAY;
	func = 3'b000; alu_op = 3'b001;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d, alu_ctr[2]=%1b,alu_ctr[1]=%1b ,alu_ctr[0]=%1b   func = %3b,   ALUOP = %3b"
	          ,$time, alu_ctr[2], alu_ctr[1], alu_ctr[0], func, alu_op);
	end
endmodule