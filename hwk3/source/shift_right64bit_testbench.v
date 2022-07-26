module shift_right64bit_testbench();
	reg signed [63:0] number;
	wire signed [63:0] result;
	shift_right64bit sr(result,number);
	initial begin
	number = 64'b0000_1100_0000_1111_0000_1100_0000_1111_0000_1100_0000_1111_0000_1100_0000_1111; //zero
	end
	initial begin
	$monitor("time=%2d,number=%64b,result=%64b",$time,number,result);
	end
endmodule