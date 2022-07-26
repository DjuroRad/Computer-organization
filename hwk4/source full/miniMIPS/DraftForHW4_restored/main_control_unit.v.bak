module main_control_unit(opcode,  reg_dest, alusrc, mem_to_reg, reg_wr, mem_rd, mem_wr, branch, alu_op);
input[3:0] opcode;
output reg_dest, alusrc, mem_to_reg, reg_wr, mem_rd, mem_wr, branch;
output [2:0] alu_op;

wire r_type, b_eq, b_ne, lw, sw, and_i, or_i, nor_i, slt_i, add_i,
		alu_src_not, reg_wr_not;
wire [3:0] opcode_not;

not(opcode_not[0], opcode[0]);
not(opcode_not[1], opcode[1]);
not(opcode_not[2], opcode[2]);
not(opcode_not[3], opcode[3]);

and(r_type, opcode_not[3], opcode_not[2], opcode_not[1], opcode_not[0]);
and(b_eq, opcode_not[3], opcode[2], opcode_not[1], opcode[0]);
and(b_ne, opcode_not[3], opcode[2], opcode[1], opcode_not[0]);
and(lw, opcode[3], opcode_not[2], opcode_not[1], opcode_not[0]);
and(sw, opcode[3], opcode_not[2], opcode_not[1], opcode[0]);
and(and_i, opcode_not[3], opcode_not[2], opcode[1], opcode_not[0]);
and(add_i, opcode_not[3], opcode_not[2], opcode_not[1], opcode[0]);
and(or_i, opcode_not[3], opcode_not[2], opcode[1], opcode[0]);
and(nor_i, opcode_not[3], opcode[2], opcode_not[1], opcode_not[0]);
and(slt_i, opcode_not[3], opcode[2], opcode[1], opcode[0]);

and(reg_dest, 1'b1, r_type);
or(alu_src_not, r_type, b_eq, b_ne);
not(alusrc, alu_src_not);
and(mem_to_reg, 1'b1, lw);
or( reg_wr_not, sw, b_eq, b_ne );
not(reg_wr, reg_wr_not);
and(mem_rd, 1'b1, lw);
and(mem_wr, 1'b1, sw);
or(branch, b_eq, b_ne);
or(alu_op[2], and_i, or_i, nor_i, slt_i);
or(alu_op[1], b_eq, b_ne, add_i, nor_i, slt_i);
or(alu_op[0], lw, sw, add_i, or_i, slt_i);

endmodule