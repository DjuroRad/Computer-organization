`define DELAY 20
module main_control_unit_testbench();
	
	reg [3:0] opcode;
	wire reg_dest, alusrc, mem_to_reg, reg_wr, mem_rd, mem_wr, branch;
	wire [2:0]alu_op;
	
	main_control_unit my_main_control_unit(opcode,  reg_dest, alusrc, mem_to_reg, reg_wr, mem_rd, mem_wr, branch, alu_op);
	initial begin
	opcode = 4'b0000;
	#`DELAY;
	opcode = 4'b1000;
	#`DELAY;
	opcode = 4'b1001;
	#`DELAY;
	opcode = 4'b0101;
	#`DELAY;
	opcode = 4'b0110;
	#`DELAY;
	opcode = 4'b0001;
	#`DELAY;
	opcode = 4'b0010;
	#`DELAY;
	opcode = 4'b0011;
	#`DELAY;
	opcode = 4'b0100;
	#`DELAY;
	opcode = 4'b0111;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d, opcode=%4b, ALUOP = %3b, reg_dest=%1b, alusrc=%1b, mem_to_reg=%1b, reg_wr=%1b, mem_rd=%1b, mem_wr=%1b, branch=%1b"
	          ,$time, opcode, alu_op, reg_dest, alusrc, mem_to_reg, reg_wr, mem_rd, mem_wr, branch);
	end
endmodule