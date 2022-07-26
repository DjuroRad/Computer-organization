module mux2x1(res, s, a, b);
input s, a, b;
output res;
wire and_a_s_not, and_b_s, s_not;

not(s_not, s);
and(and_a_s_not, a,s_not);
and(and_b_s, b, s);

or( res, and_a_s_not, and_b_s);

endmodule