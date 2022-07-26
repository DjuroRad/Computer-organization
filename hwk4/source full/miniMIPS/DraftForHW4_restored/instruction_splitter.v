module instruction_splitter(opcode, rs, rt, rd, immed, funct, instruction);
			
	output [2:0] funct;
	output [5:0] immed;
	output [2:0] rs, rt, rd;
	output [3:0] opcode;
	input [15:0] instruction;
	//FUNCT
	genvar i;
	generate
		for( i = 0; i<3; i = i+1 )
			begin: loop1
				and( funct[i], instruction[i], 1'b1);
			end
	endgenerate
	
	//IMMed
	generate
		for( i = 0; i<6; i = i+1 )
			begin: loop2
				and( immed[i], instruction[i], 1'b1);
			end
	endgenerate
	
	//RD
	generate
		for( i = 0; i<3; i = i+1 )
			begin: loop3
				and( rd[i], instruction[i+3], 1'b1);
			end
	endgenerate
	
	//RT
	generate
		for( i = 0; i<3; i = i+1 )
			begin: loop4
				and( rt[i], instruction[i+6], 1'b1);
			end
	endgenerate
	
	//RS
	generate
		for( i = 0; i<3; i = i+1 )
			begin: loop5
				and( rs[i], instruction[i+9], 1'b1);
			end
	endgenerate
	
	//OPCODE
	generate
		for( i = 0; i<4; i = i+1 )
			begin: loop6
				and( opcode[i], instruction[i+12], 1'b1);
			end
	endgenerate	
endmodule