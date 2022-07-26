module MiniMIPS(instruction, result, clk);//, read_data_rs, read_data_rt, alu_ctr,rs, rt, rd, rt_rd_address, immediate_extended);
	
	//this module is a top-level entity
	//all modules in this project that have to use just structural verilog (except register & data modules)
	//MiniMIPS has to work correctly for 15 instruction.
	//alu32 design has to stay same with assignment3
	output [31:0] result;		
	input [15:0] instruction;//this is the instruction taken from the 
	input clk;

	reg [5:0] program_counter = 6'b0;//enough for my 2^6 memory containing 2^64 possible instructions!
	wire [5:0] new_pc;
	
	wire [31:0] read_data_rs, read_data_rt;
	wire [31:0]  alu_result, memory_data_result , alu_in_2, shifted_immediate_extended, program_counter_jump, new_program_counter;
	
	wire [31:0] immediate_extended;
	//get it from the register data
	
	//for memory file read & write using followings
	//$readmemb("registers.mem", mipsMOdulename.registerModuleName.registers);
	//$writememb("registers_outp.mem", mipsMOdulename.registerModuleName.registers);

	//wire[2:0] rd, rt_rd_address;
	wire[2:0] rs,rt, rd, rt_rd_address;
	//wire[5:0] funct, opcode;
	wire[2:0] funct;
	wire[3:0] opcode;
	wire[5:0] immed;
	
	//control unit output signals
	wire reg_dest, branch, memRead, memToReg, memWrite, ALUsrc, RegWrite, zero;//only zero is output of the ALU, the others are for something else
	wire [2:0] alu_op;
	wire [2:0] alu_ctr;
	//SPLIT the instruction
	instruction_splitter i_s(opcode, rs, rt, rd, immed, funct, instruction);
	
	//Control unit
	main_control_unit main_control(opcode, reg_dest, ALUsrc, memToReg, RegWrite, memRead, memWrite, branch, alu_op);

	//ALU CONTROL UNIT
	alu_control_unit alu_ctr_unit(alu_ctr, funct, alu_op);
	
	//ALU 
	alu_32bit alu_unit(alu_result, alu_ctr, read_data_rs, alu_in_2, zero);

	//Choosing between RD and RT depending on the type of the instruction that is being executed
	mux5x1 mux5(rt_rd_address, reg_dest, rt, rd);
	
	//extend the IMMEDIATE value
	immediate_extender i_e(immediate_extended, immed);

	//CHOOSE BETWEEN EXTENDED VALUE AND RD/RT
	//ALUSRC is the select bit
	mux_32bit mux32(alu_in_2, ALUsrc, read_data_rt, immediate_extended);

	//SHIFT left 2, this is not needed as we are working with bytes here, one by one, though the logic for this works properly
	//shift_left_2_32bit sll2(immediate_extended, immediate_extended);
	
	//CHOOSE between MEMORY_DATA output and ALU_RESULT
	mux_32bit mux32_memtoreg(result, memToReg, alu_result, memory_data_result);
	
	//PROGRAM COUNTER UNIT HERE
	
	//BNE and BEQ branch in different cases
	wire branch_final_decision;
	wire not_zero, not_op0;
	
	wire beq_branch, bne_branch;
	and( beq_branch, branch, zero, opcode[0] );
	
	not(not_zero, zero);
	not(not_op0, opcode[0]);
	and( bne_branch, branch, not_zero, not_op0);
	
	or( branch_final_decision, beq_branch, bne_branch );
	
	program_counter_unit pc_unit(new_pc, program_counter, immediate_extended, branch_final_decision );
	//ADD INSTRUCTION MEMORY
	//instruction_memory_block instr_memory(instruction, program_counter, clk);
	
	//ADD REGISTER MEMORY
	mips_registers regs( read_data_rs, read_data_rt, result, rs, rt, rt_rd_address, RegWrite, clk );
	//( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	//ADD DATA'S MEMORY
	//module data_memory(read_data,address,write_data,mem_write,mem_read,clk);
	data_memory data_mem( memory_data_result, alu_result, read_data_rt, memWrite, memRead, clk);
	
	//Verilog coding guidelines 
	//Guideline #1: When modeling sequential logic, use nonblocking assignments.
	//Guideline #2: When modeling latches, use nonblocking assignments.
	//Guideline #3: When modeling combinational logic with an always block, use blocking assignments.

	//we need to change pc here therefore there is always here.
	always @(negedge clk) 
		begin
		program_counter <= new_pc;
		end
	
endmodule