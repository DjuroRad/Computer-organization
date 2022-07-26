module shift_right64bit(res,number);
output [63:0] res;
input [63:0] number;

//now take the result and shift it using the number
//MSB will be zero! so we can skip it and go until 63
and(res[63], 1'b0,1'b0);

genvar i;
generate
	for( i = 0; i<63; i = i+1 )
		begin: parallel_loop_or2
			and( res[i], number[i+1] ,1'b1);
		end
endgenerate

endmodule