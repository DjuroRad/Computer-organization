`define DELAY 20
module mux_64bit_testbench();
	reg [63:0]a,b;
	reg s;
	wire [63:0]out;
	mux_64bit my_mux(out,s,a,b);
	
	initial begin
		s = 1'b0; a = 64'b1001_0000_0000_0000_0000_0000_0000_1010_1001_0000_0000_0000_0000_0000_0000_1010; b =64'b0001_0000_0000_0000_0000_0000_0001_1110_0001_0000_0000_0000_0000_0000_0001_1110;//or
		#`DELAY;
		s = 1'b1; a = 64'b1001_0000_0000_0000_0000_0000_0000_1010_1001_0000_0000_0000_0000_0000_0000_1010; b =64'b0001_0000_0000_0000_0000_0000_0001_1110_0001_0000_0000_0000_0000_0000_0001_1110;//or
		#`DELAY;
	end
	
endmodule