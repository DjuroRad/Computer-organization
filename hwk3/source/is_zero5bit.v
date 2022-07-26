module is_zero5bit(res, number);
input [5:0]number;
output res;

wire o0,o1,o2,o3,o4,n0;

or(o0, number[0], number[1]);
or(o1, number[2], number[3]);
or(o4, number[4], number[5]);
or(o2,o1,o0);
or(o3, o2, o4);
not(res, o3);

endmodule