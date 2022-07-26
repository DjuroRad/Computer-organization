module mux5x1(result, select, num1, num2);
input [4:0] num1, num2;
input select;
output [4:0] result;

genvar j;
generate
	for( j = 0; j<5; j = j+1 )
		begin: parallel_loop_mux
			mux2x1 multiplexer( result[j], select, num1[j], num2[j]);
	end
endgenerate

endmodule