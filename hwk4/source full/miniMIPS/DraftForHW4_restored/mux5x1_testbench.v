`define DELAY 20
module mux5x1_testbench();
	reg [4:0]a,b;
	reg s;
	wire [4:0]out;
	mux5x1 my_mux(out,s,a,b);
	initial begin
	s = 1'b1; a = 32'b01010; b =32'b11110;//or
	#`DELAY;
	s = 1'b0; a = 32'b01010; b =32'b11110;//or
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,a=%5b,b=%5b,s=%1b,out=%5b"
	          ,$time,a,b,s,out);
	end
endmodule