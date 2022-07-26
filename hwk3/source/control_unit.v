module control_unit( init, lsb_sel, shift_load, l_lsb, finish_cycle, clk, i_eq_0);

input i_eq_0,clk;
output init, lsb_sel, shift_load, l_lsb, finish_cycle;

reg[1:0] present_state = 2'b0;
wire[1:0] next_state;

wire S1_not, S0_not;
not(S1_not, present_state[1]);
not(S0_not, present_state[0]);

_xor myxor(next_state[1], present_state[0], present_state[1]);


wire s1_not_s0_not, s1_s0_not, s1_s0_i_eq0;
and(s1_not_s0_not, S1_not, S0_not);
and(s1_s0_not, present_state[1], S0_not);

wire i_eq_0_not;
not(i_eq_0_not, i_eq_0);
and(s1_s0_i_eq0, present_state[0], present_state[1], i_eq_0_not);

or(next_state[0], s1_not_s0_not, s1_s0_not, s1_s0_i_eq0);

//make states here
wire s0,s1,s2,s3;
and(s0, S1_not, S0_not);
and(s1, S1_not, present_state[0]);
and(s2, present_state[1], S0_not);
and(s3, present_state[1], present_state[0]);

//init = S0
and(init, s0, 1'b1);
//lsb_sel S3
and(lsb_sel, s3, 1'b1);
//shift_load S0 + S1 + S3
or(shift_load, s0, s1, s3);
//l_lsb S1
and(l_lsb, s1, 1'b1);
//finish_cycle S1
and(finish_cycle, s1, 1'b1);

always @(posedge clk) begin
	present_state <= next_state;
end
endmodule