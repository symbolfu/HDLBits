`default_nettype none
module top_module(
    input x,
    input y,
    output z
);

    wire temp[4];


    assign temp[0] = (x ^ y) & x;
    assign temp[2] = (x ^ y) & x;

    assign temp[1] =  ~(x ^ y);
    assign temp[3] =  ~(x ^ y);


    assign z = (temp[0] | temp[1]) ^ (temp[2] & temp[3]);


endmodule