`define CLOCK 4
module mult_64bit(product, a, b, clk);

input [31:0] a, b;
input clk;
output [63:0]product;

wire [63:0] prod_wire;
wire init, lsb_sel, shift_load, l_lsb, cycle_finish, i_eq_0;

control_unit cu(init, lsb_sel, shift_load, l_lsb, cycle_finish, clk, i_eq_0);
datapath dp(product, a, b, lsb_sel, init, shift_load, l_lsb, clk, i_eq_0, cycle_finish);

//module datapath(res, multiplicant, multiplier, lsb_select, init, shift_load, l_lsb, clk, i_eq_0, cycle_finish);
//module control_unit( init, lsb_sel, shift_load, l_lsb, finish_cycle, clk, i_eq_0);
//define clock cycle


always @(posedge clk) begin
	//product <= prod_wire;
end

endmodule