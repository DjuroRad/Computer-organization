`define DELAY 20
module mux_32bit_testbench();
	reg [31:0]a,b;
	reg s;
	wire [31:0]out;
	mux_32bit my_mux(out,s,a,b);
	
	initial begin
		s = 1'b0; a = 32'b1001_0000_0000_0000_0000_0000_0000_1010; b =32'b0001_0000_0000_0000_0000_0000_0001_1110;//or
		#`DELAY;
		s = 1'b1; a = 32'b1001_0000_0000_0000_0000_0000_0000_1010; b =32'b0001_0000_0000_0000_0000_0000_0001_1110;//or
		#`DELAY;
	end
	
endmodule