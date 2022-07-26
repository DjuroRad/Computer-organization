`define DELAY 20
module is_zero5bit_testbench();
	reg [5:0]number;
	wire res;
	
	is_zero5bit is_zero(res,number);
	initial begin
	number =6'b000010;
	#`DELAY;
	number =6'b000000;
	#`DELAY;
	number =6'b111111;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,number=%5b,res=%1b"
	          ,$time,number, res);
	end
endmodule