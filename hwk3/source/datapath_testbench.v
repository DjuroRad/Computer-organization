`define CLOCK 4
//`timescale 1 ps / 1 ps
module datapath_testbench();


//datapath(res, multiplicant, multiplier, lsb_select, init, shift_load, l_lsb, clk, i_eq_0);

	reg [31:0] multiplicant, multiplier;
	reg lsb_select, init, shift_load, l_lsb, clk, cycle_finish;
	wire [63:0]res;
	wire i_eq_0;
	datapath dp(res, multiplicant, multiplier, lsb_select, init, shift_load, l_lsb, clk,i_eq_0, cycle_finish);
	
//output i_eq_0, p_lsb, a_sel;
//input wr_prod;//writes to product when the last state occurs
//input clk;//clock cycle		
	initial begin
	multiplicant = 32'b0000_0000_0000_0000_0000_0000_0000_0011;
	multiplier = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
	clk = 1'b0;
	lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b0; cycle_finish = 1'b0;
	//1st cycle
	#`CLOCK;//init
		lsb_select = 1'b0; init = 1'b1; shift_load = 1'b1; l_lsb = 1'b0; cycle_finish = 1'b0;
	#`CLOCK;//store lsb
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b1; cycle_finish = 1'b0;
	#`CLOCK;//shift
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b0; l_lsb = 1'b0; cycle_finish = 1'b0;
	#`CLOCK;//store addition result
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b0; cycle_finish = 1'b1;
	
	
	//2nd cycle
	#`CLOCK;//store lsb
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b1; cycle_finish = 1'b0;
	#`CLOCK;//shift
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b0; l_lsb = 1'b0; cycle_finish = 1'b0;
	#`CLOCK;//store addition result
		lsb_select = 1'b1; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b0; cycle_finish = 1'b1;
		
	//3rd cycle
	#`CLOCK;//store lsb
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b1; cycle_finish = 1'b0;
	#`CLOCK;//shift
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b0; l_lsb = 1'b0; cycle_finish = 1'b0;
	#`CLOCK;//store addition result
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b1; l_lsb = 1'b0; cycle_finish = 1'b1;
		
	//continue just shifting 27 more times
	#`CLOCK;//store addition result
		lsb_select = 1'b0; init = 1'b0; shift_load = 1'b0; l_lsb = 1'b0; cycle_finish = 1'b1;
	#236 $finish;
	end
	
	//define clock cycle
	always 
		begin
			#4 clk = ~clk;
		end
		
	initial begin
	$monitor("time=%2d,i_eq_0=%1b,p_lsb=%1b"
	          ,$time, i_eq_0, l_lsb);
	end
	
	

endmodule