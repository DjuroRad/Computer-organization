module alu_1bit(res, c_i_plus_1, alu_op, a, b, c_i, less_i);
input a, b, c_i, less_i;
input [2:0] alu_op;
output res, c_i_plus_1;

wire  b_select, b_select_xor_input, alu_op_0_not, alu_op_1_not, alu_op_2_not, sub_alu_op, slt_alu_op,
		a_or_b, a_and_b, a_and_b_not, a_xor_b,
		a_xor_b_and_c_i, a_xor_b_or_c_i,
		a_xor_b_and_c_i_not,
		a_xor_b_xor_c_i,
		a_nor_b
		;
//select b, sub and slt we need complement of b
not(alu_op_0_not, alu_op[0]);
not(alu_op_1_not, alu_op[1]);
not(alu_op_2_not, alu_op[2]);

and( slt_alu_op, alu_op[2], alu_op_1_not, alu_op_0_not);
and( sub_alu_op, alu_op_2_not, alu_op[1], alu_op_0_not);
or(b_select_xor_input, sub_alu_op, slt_alu_op);
_xor my_xor(b_select, b, b_select_xor_input);

//now we have our b/b' depending on the operation needed to execute
and( a_and_b, a, b_select);
not( a_and_b_not, a_and_b);

or( a_or_b, b_select, a);
and(a_xor_b, a_and_b_not, a_or_b);
//now we have finished the first step of finding a xor b
//xor it with c_i now
and(a_xor_b_and_c_i, a_xor_b, c_i);
or(a_xor_b_or_c_i, a_xor_b, c_i);
not(a_xor_b_and_c_i_not, a_xor_b_and_c_i);
and(a_xor_b_xor_c_i, a_xor_b_and_c_i_not, a_xor_b_or_c_i);

//nor missing, calculate it by adding one inverter
not( a_nor_b, a_or_b ); 
//c_i_plus_1
or( c_i_plus_1, a_and_b, a_xor_b_and_c_i);
// a_xor_b_xor_c_i === ADD/MULT/SUB/SLT --- will be used for all of these operations
// a_or_b == OR 
// a_and_b == AND
// a_xor_b == XOR
// a_nor_b == NOR

//just mux them and choose the ideal one
//module mux8x1(res, s, i0, i1, i2, i3, i4, i5, i6, i7);
mux8x1 my_mux_alu(
					res, 
					alu_op,
					
					a_xor_b_xor_c_i,
					a_xor_b,
					a_xor_b_xor_c_i,
					a_xor_b_xor_c_i,
					a_xor_b_xor_c_i,
					a_nor_b,
					a_and_b,
					a_or_b);


endmodule