module immediate_extender(immediate_extended, immed_in);

output [31:0]immediate_extended;
input [5:0]immed_in;

genvar i;
generate
	for( i = 0; i<6; i = i+1 )
		begin: loop1
			and( immediate_extended[i], immed_in[i], 1'b1);
		end
endgenerate

generate
	for( i = 6; i<32; i = i+1 )
		begin: loop2
			and( immediate_extended[i], immed_in[5], 1'b1);
		end
endgenerate

endmodule