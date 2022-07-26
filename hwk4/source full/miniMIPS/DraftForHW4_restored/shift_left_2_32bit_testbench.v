`define DELAY 20
module shift_left_2_32bit_testbench();
	reg signed [31:0] number;
	wire signed [31:0] result;
	shift_left_2_32bit sl_2_32bit(result,number);
	
	initial begin
	number = 32'b0000_1100_0000_1111_0000_1100_0000_1111; //zero
	#`DELAY;
	number = 32'b0001_1101_0000_1111_1111_1100_1111_1011; //zero
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,number=%32b,result=%32b",$time,number,result);
	end
endmodule