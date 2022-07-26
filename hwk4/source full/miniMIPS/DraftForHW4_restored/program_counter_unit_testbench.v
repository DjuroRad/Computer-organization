module program_counter_unit_testbench();
		
	//module program_counter_unit(new_program_counter, program_counter, shifted_immediate_extended, branch );
	wire[5:0] new_program_counter;
	
	reg[5:0] program_counter;
	reg[31:0] shifted_immediate_extended;
	reg branch;
	
	program_counter_unit pc_unit(new_program_counter,program_counter,shifted_immediate_extended,branch);
			
	initial begin
	shifted_immediate_extended = 32'b11111_11111_11111_11111_11111_11111_11; 
	program_counter = 5'b00111; //last adress in here
	branch = 1'b0;
	#20;
	
	shifted_immediate_extended = 32'b00000_00000_00000_00000_00000_00001_11; 
	program_counter = 5'b00100; //last adress in here
	branch = 1'b1;
	
	#20;
	end
	initial begin

	end
endmodule