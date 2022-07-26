module shift_left_2_32bit(res,number);
output [31:0] res;
input [31:0] number;

//now take the result and shift it using the number
//LSB will be zero! so we can skip it and go until 63
and(res[0], 1'b0,1'b0);
and(res[1], 1'b0,1'b0);

genvar i;
generate
	for( i = 2; i<32; i = i+1 )
		begin: loop_shift_left
			and( res[i], number[i-2] ,1'b1);
		end
endgenerate

	

endmodule