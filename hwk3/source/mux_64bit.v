module mux_64bit(result, select, num1, num2);
input [63:0] num1, num2;
input select;
output [63:0] result;

genvar j;
generate
	for( j = 0; j<64; j = j+1 )
		begin: parallel_loop_mux
			mux2x1 multiplexer( result[j], select, num1[j], num2[j]);
		end
endgenerate

endmodule