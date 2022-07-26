`define DELAY 20
module mux2x1_testbench();
	reg a,b,s;
	wire out;
	mux2x1 my_mux(out,s,a,b);
	initial begin
	s = 1'b0; a =1'b1; b = 1'b0;
	#`DELAY;
	s = 1'b1; a =1'b1; b = 1'b0;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,a=%1b,b=%1b,s=%1b,out=%1b"
	          ,$time,a,b,s,out);
	end
endmodule