module data_memory(read_data,address,write_data,mem_write,mem_read,clk);

//by convention, I wrote first outputs then inputs.
output reg [31:0] read_data;
input [31:0] address; //adress will be 18 bits(256KB) 
input [31:0] write_data;
input mem_read,mem_write,clk;

reg [31:0] memory [31:0]; // memory array.(each data will be 32 bits)

//No file operation here, it will be in testbench.

//Since there was a problem in loadword, I read and write memory each clock cyle by checking signals.
always @(*) 
begin
	//write to memory by extending adress(zero extend)
	if (mem_write)
		begin
		memory[address] <= write_data;
		end
	//read from memory by extending adress(zero extend)
	if (mem_read)
		begin
		read_data <= memory[address];
		end
end


endmodule