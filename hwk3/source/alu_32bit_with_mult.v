`define CLOCK 4
module alu_32bit_with_mult(result_final_after_mult, alu_op, a, b, clk);
input [31:0] a, b;
input [2:0] alu_op;
input clk;
wire [31:0] result_final;
output [31:0]result_final_after_mult;

wire overflow, carry_in, slt, alu_op_0_not, alu_op_1_not, alu_op_2_not, slt_alu_op, sub_alu_op, mult_alu_op;
wire [31:0] prev_carry_out, slt_result, res;

//or final_carry_out(carry_out, second_carry_out, first_carry_out);

//module alu_1bit(res, c_i_plus_1, alu_op, a, b, c_i, less_i);

//calculate first carry_in with respect to ALU_OP off course
not(alu_op_0_not, alu_op[0]);
not(alu_op_1_not, alu_op[1]);
not(alu_op_2_not, alu_op[2]);

and( slt_alu_op, alu_op[2], alu_op_1_not, alu_op_0_not);
and( sub_alu_op, alu_op_2_not, alu_op[1], alu_op_0_not);
or(carry_in, sub_alu_op, slt_alu_op);

//first step depends on the input --- notice: carry_in --- in full_adder
alu_1bit alu_1bit_0bit( res[0], prev_carry_out[0], alu_op, a[0], b[0], carry_in, slt );
//do it for the first 31
//31 will be written separately in order to make sure the output is alright

genvar i;
generate
	for( i = 1; i<32; i = i+1 )
		begin: parallel_loop_or
			alu_1bit alu_ith_bit( res[i], prev_carry_out[i], alu_op, a[i], b[i], prev_carry_out[i-1], 1'b0 );
		end
endgenerate

//after this addition is supposed to work properly

//calculate overflow with respect to carry out
_xor my_xor_0(overflow, prev_carry_out[31], prev_carry_out[30]);
//calculate set for set less than!
_xor my_xor(slt, overflow, res[31]);
//recalculate the less_i in order to set SLT we found after all the calculations
//alu_1bit alu_1bit_0bit_update( res[0], prev_carry_out[0], a[0], b[0], carry_in, slt );

//find slt result since its result is only 1bit
//and(slt_result, 32'b0000_0000_0000_0000_0000_0000_0000_0001, slt);
generate
	for( i = 1; i<32; i = i+1 )
		begin: parallel_loop_extender
			and( slt_result[i], 1'b0, 1'b0);
		end
endgenerate
or(slt_result[0], slt, 1'b0);
//final result will be either slt_result or result from the ALU, for slt ALU is calculating the difference ( sum )
//we need multiplexers to choose between those 2
//slt_alu_op can work also as a selector for our muxes of course, each bit will need a mux

generate
	for( i = 0; i<32; i = i+1 )
		begin: parallel_loop_final_result
			mux2x1 last_mux( result_final[i], slt_alu_op, res[i], slt_result[i]);
		end
endgenerate


//Add multiplier to all this
//module mult_64bit(product, a, b, clk);

wire [63:0]product;


wire init, lsb_sel, shift_load, l_lsb, cycle_finish, i_eq_0;

control_unit cu(init, lsb_sel, shift_load, l_lsb, cycle_finish, clk, i_eq_0);
datapath dp(product, a, b, lsb_sel, init, shift_load, l_lsb, clk, i_eq_0, cycle_finish);

//chooses multiplication if alu op is multiplication code!

and(mult_alu_op, alu_op_2_not, alu_op[1], alu_op[0]);
generate
	for( i = 0; i<32; i = i+1 )
		begin: parallel_loop_final_result_after_mult
			mux2x1 final_mux( result_final_after_mult[i], mult_alu_op, result_final[i], product[i]);
		end
endgenerate

endmodule