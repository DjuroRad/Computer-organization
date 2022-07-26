module is_one5bit(res, number);
input [5:0]number;
output res;

wire o0,o1,o2,o3,not_o3,n0;

or(o0, number[5], number[4]);
or(o1, number[3], number[2]);
//or(o4, number[4], number[5]);
or(o2,o1,o0);
or(o3, o2, number[1]);
not(not_o3, o3);
and(res, not_o3, number[0]);

endmodule