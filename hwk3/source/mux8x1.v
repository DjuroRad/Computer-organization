module mux8x1(res, s, i0, i1, i2, i3, i4, i5, i6, i7);
input i0, i1, i2, i3, i4, i5, i6, i7;
input [2:0] s;
output res;

wire  i0_or_i1, i2_or_i3, i4_or_i5, i6_or_i7,
		i0i1_or_i2i3, i4i5_or_i6i7;
		
//7 mux2x1s, each level halved, first 4 muxes, 2nd 2muxes, 3rd 1mux
mux2x1 mux_0( i0_or_i1, s[0], i0, i1 );
mux2x1 mux_1( i2_or_i3, s[0], i2, i3 );
mux2x1 mux_2( i4_or_i5, s[0], i4, i5 );
mux2x1 mux_3( i6_or_i7, s[0], i6, i7 );


mux2x1 mux_4( i0i1_or_i2i3, s[1], i0_or_i1, i2_or_i3 );
mux2x1 mux_5( i4i5_or_i6i7, s[1], i4_or_i5, i6_or_i7 );

mux2x1 mux_6( res, s[2], i0i1_or_i2i3, i4i5_or_i6i7 );

endmodule