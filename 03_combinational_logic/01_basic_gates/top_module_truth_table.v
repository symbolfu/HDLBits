`default_nettype none
module top_module(
    input x3,
    input x2,
    input x1,
    output f
);

    wire [1:0] temp;

    assign temp[0] = (~x3) & x2;
    assign temp[1] = x3 & x1;

    // output 
    assign f = | temp;
    

endmodule