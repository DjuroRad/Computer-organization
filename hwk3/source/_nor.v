module _nor(res, a, b);
input a, b;
output res;
wire or_a_b;

or( or_a_b, a, b );
not(res, or_a_b);
endmodule