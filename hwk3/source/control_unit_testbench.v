`define CLOCK 4
//`timescale 1 ps / 1 ps
module control_unit_testbench();


//datapath(res, multiplicant, multiplier, lsb_select, init, shift_load, l_lsb, clk, i_eq_0);

	wire init, lsb_sel, shift_load, l_lsb, finish_cycle;
	reg i_eq_0, clk;
	//module control_unit(init, lsb_sel, shift_load, l_lsb, finish_cycle, clk, i_eq_0);
	control_unit cu(init, lsb_sel, shift_load, l_lsb, finish_cycle, clk, i_eq_0);
	
	//output i_eq_0, p_lsb, a_sel;
	//input wr_prod;//writes to product when the last state occurs
	//input clk;//clock cycle		
	initial begin
	clk = 1'b0;
	i_eq_0 = 1'b0;
	//1st cycle
	#36 i_eq_0 = 1'b1;
	#52 $finish;
	end
	
	//define clock cycle
	always 
		begin
			#2	clk = ~clk;
		end
		
	initial begin
	$monitor("time=%2d, init=%1b, lsb_sel=%1b, shift_load=%1b, l_lsb=%1b, finish_cycle=%1b "
	          ,$time, init, lsb_sel, shift_load, l_lsb, finish_cycle);
	end
	
	

endmodule