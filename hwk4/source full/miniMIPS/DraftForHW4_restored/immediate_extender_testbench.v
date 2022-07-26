`define DELAY 20
module immediate_extender_testbench();

	reg [5:0]immed;
	wire [31:0]immed_out;
	//  module mux8x1(immediate_extended, immed_in);
	immediate_extender imm_extend(immed_out, immed);
	initial begin
	immed = 6'b000010;
	#`DELAY;
	immed = 6'b100010;
	#`DELAY;
	immed = 6'b011010;
	#`DELAY;
	immed = 6'b000011;
	#`DELAY;
	immed = 6'b111111;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d, immed=%32b,  immed_out=%6b"
	          ,$time, immed_out, immed);
	end
endmodule