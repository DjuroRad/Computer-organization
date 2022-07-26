module _xor(res, a, b);
input a, b;
output res;
wire a_b_not, a_not_b, a_not, b_not;

not (a_not, a);
not (b_not, b);

and( a_b_not, a, b_not );
and( a_not_b, a_not, b);

or( res, a_b_not, a_not_b );

endmodule