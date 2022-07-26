module adder_32bit(sum, carry_out, a, b, carry_in);
input [31:0] a, b;
input carry_in;
output [31:0] sum;
output carry_out;


wire temp_sum, first_carry_out, second_carry_out;
wire [30:0] prev_carry_out;

//or final_carry_out(carry_out, second_carry_out, first_carry_out);

//module alu_1bit(res, c_i_plus_1, alu_op, a, b, c_i, less_i);


//first step depends on the input --- notice: carry_in --- in full_adder
full_adder fa0bit( sum[0], prev_carry_out[0], a[0], b[0], carry_in );
//do it for the first 31
//31 will be written separately in order to make sure the output is alright

genvar i;
generate
	for( i = 1; i<31; i = i+1 )
		begin: parallel_loop_or
			full_adder fa( sum[i], prev_carry_out[i], a[i], b[i], prev_carry_out[i-1] );
		end
endgenerate

full_adder fa32bit( sum[31], carry_out, a[31], b[31], prev_carry_out[30] );

endmodule