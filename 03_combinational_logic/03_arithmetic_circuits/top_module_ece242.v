`default_nettype none

module top_module(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);


    assign s = a + b;
    /*
        + +   s[7] = 1  => overflow
        -+     不会overflow
        --    s[7] = 1  => overflow
    */ 
    assign overflow = ((~a[7]) & (~b[7]) & s[7]) | (a[7] & b[7] & (~s[7]));



endmodule

// 1001
// 1001
// 0010


//0111
//0111