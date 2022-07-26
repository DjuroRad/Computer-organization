`define DELAY 20
module mux8x1_testbench();
	reg i0, i1, i2, i3, i4, i5, i6, i7;
	reg [2:0] s;
	wire out;
	
	mux8x1 my_mux(out,s,i0, i1, i2, i3, i4, i5, i6, i7);
	initial begin
	s = 3'b000; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b001; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b010; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b011; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b100; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b101; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b110; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	s = 3'b111; i0 =1'b1; i1 = 1'b0; i2 = 1'b0;i3 = 1'b1;i4 = 1'b0;i5 = 1'b0;i6 = 1'b1;i7 = 1'b1;
	#`DELAY;
	end
	initial begin
	$monitor("time=%2d,i7=%1b,i6=%1b,i5=%1b,i4=%1b,i3=%1b,i2=%1b,i1=%1b,i0=%1b,s2=%1b,s1=%1b,s0=%1b,out=%1b"
	          ,$time,i7, i6, i5, i4, i3, i2, i1, i0,s[2], s[1], s[0], out);
	end
endmodule