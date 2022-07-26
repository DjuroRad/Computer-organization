module instruction_memory_block(instruction,read_adress,clk);

//by convention, I wrote first outputs then inputs.
output reg [15:0] instruction;
input [5:0] read_adress; //there will be 2^6 addresses ---> 64 possible insturcitons each 16bits ---> 16*64bits of memory
input clk;

reg [15:0] instr_memory [64:0]; //64 instructions here for storing this, will suffice for our needs!

//No file operation here, it will be in testbench.
//get instruction by extending adress(zero extend)
always @(posedge clk) 
begin
	instruction <= instr_memory[read_adress];
end

endmodule