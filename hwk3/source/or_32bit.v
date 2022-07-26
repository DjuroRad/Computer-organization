module or_32bit(res, a, b);
input [31:0] a, b;
output [31:0] res;

//for loop is used in order to avoid writing 32 unnecesary lines of codes
//it still holds its structural verilog design


genvar i;


generate
	for( i = 0; i<32; i = i+1 )
		begin: parallel_loop_or
			or( res[i], a[i], b[i] );
		end
endgenerate

endmodule