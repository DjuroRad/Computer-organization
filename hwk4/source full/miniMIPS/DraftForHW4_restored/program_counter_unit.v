module program_counter_unit(new_program_counter, program_counter, shifted_immediate_extended, branch );

output [5:0] new_program_counter;

input branch;
input [5:0] program_counter;
input [31:0] shifted_immediate_extended;

wire [31:0] extended_pc;
wire [31:0] new_program_counter_wire, program_counter_jump, pc_incremented;

//EXTEND PC to 32 BITS IN ORDER TO BE ABLE TO PERFORM ADDITION
genvar j;
generate
	for( j = 0; j<6; j = j+1 )
		begin: extend
			and( extended_pc[j], program_counter[j], 1'b1);
		end
endgenerate
generate
	for( j = 6; j<32; j = j+1 )
		begin: extend2
			and( extended_pc[j], 1'b0, 1'b0);
		end
endgenerate

//PROGRAM COUNTER, STARTS FROM the first instruction of the instructoin memory
wire carry_out_pc;
//increments program coutner by 1, meaning it will go to the next instruction in the instruction memory data
adder_32bit adder_pc(pc_incremented, carry_out_pc, 32'b0000_0000_0000_0000_0000_0000_0000_0001, extended_pc, 1'b0);

wire carry_out_pc_jump;
adder_32bit adder_pc_jump(program_counter_jump, carry_out_pc_jump, shifted_immediate_extended, pc_incremented, 1'b0);
//and(branch_and_zero, branch, zero);

mux_32bit pc_selection(new_program_counter_wire, branch, pc_incremented, program_counter_jump );

//GETTING THE LAST FIVE BITS OF OUR RESULT!
generate
	for( j = 0; j<6; j = j+1 )
		begin: extend3
			and( new_program_counter[j], new_program_counter_wire[j], 1'b1);
		end
endgenerate
	
endmodule