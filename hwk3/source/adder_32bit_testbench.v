`define DELAY 20
module adder_32bit_testbench();
	reg signed [31:0] a;
	reg signed [31:0] b;
	wire signed [31:0] result;
	reg carry_in;
	wire carry_out;
	adder_32bit adder(result, carry_out, a, b, carry_in);
	initial begin
	a = 32'b00000001000000000000000000000111; b =32'b00000000000000000000000000111111; carry_in = 1'b0;
	#`DELAY;
	a = 32'b00000000000000000000000010011011; b =32'b00000000000000000000000000111111; carry_in = 1'b0;
	#`DELAY;
	a = 32'b11111111111111111111111111111110; b =32'b11111111111111111111111111101110; carry_in = 1'b0;
	#`DELAY;
	a = 32'b11111111111111111111001000010011; b =32'b00000000000000000100000000100000; carry_in = 1'b0;
	#`DELAY;
	a = 32'b11111111111111111111011000010011; b =32'b00000000000000000000000000000000; carry_in = 1'b1;
	#`DELAY;
	a = 32'b01111111111111111111111111111111; b =32'b00000000000000000000000001000011; carry_in = 1'b0;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d, a=%2d, b=%2d, carry_in=%1b, carry_out=%1b, result=%2d",$time,a,b,carry_in,carry_out,result);
	end
endmodule