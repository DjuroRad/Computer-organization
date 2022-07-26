module alu_control_unit(alu_ctr, func, alu_op);
input [2:0] func, alu_op;
output [2:0] alu_ctr;

wire[2:0] func_not;
wire[2:0] alu_op_not;

wire f1_not_f2_not_f0_not, f2_f1_not_f0_not, f2_f1_not_f0;//for ALU_CTR_2

wire f2_not_f1_f0_not, a2_a1_not_a0_not, a2_a1_not_a0, a2_not_a1_a0_not;// fpr ALU_CTR_1

wire f1_f0, a2_a1_a0_not, f2_aluop_not;

not(func_not[0], func[0]);
not(func_not[1], func[1]);
not(func_not[2], func[2]);
	
not(alu_op_not[0], alu_op[0]);
not(alu_op_not[1], alu_op[1]);
not(alu_op_not[2], alu_op[2]);


and(f1_not_f2_not_f0_not, func_not[0], func_not[1], func_not[2], alu_op_not[2], alu_op_not[1], alu_op_not[0] );
and(f2_f1_not_f0_not, func_not[0], func_not[1], func[2], alu_op_not[2], alu_op_not[1], alu_op_not[0] );
and(f2_f1_not_f0, func[0], func_not[1], func[2], alu_op_not[2], alu_op_not[1], alu_op_not[0] );
or(alu_ctr[2], f2_f1_not_f0, f2_f1_not_f0_not, f1_not_f2_not_f0_not, alu_op[2]);


and( f2_not_f1_f0_not, func_not[2], func[1], func_not[0], alu_op_not[2], alu_op_not[1], alu_op_not[0] );
and( a2_a1_not_a0_not, alu_op[2], alu_op_not[1], alu_op_not[0] );
and( a2_a1_not_a0, alu_op[2], alu_op_not[1], alu_op[0] );
and( a2_not_a1_a0_not, alu_op_not[2], alu_op[1], alu_op_not[0] );
or( alu_ctr[1], f1_not_f2_not_f0_not,f2_f1_not_f0, f2_not_f1_f0_not, a2_a1_not_a0_not, a2_a1_not_a0 ,a2_not_a1_a0_not);


and(f1_f0, func[1], func[0], alu_op_not[2], alu_op_not[1], alu_op_not[0]  );
and(a2_a1_a0_not, alu_op[2],  alu_op[1], alu_op_not[0]);
and( f2_aluop_not, func[2], alu_op_not[2], alu_op_not[1], alu_op_not[0]);

or( alu_ctr[0], f2_aluop_not,  f1_f0, a2_a1_not_a0, a2_a1_a0_not );

endmodule