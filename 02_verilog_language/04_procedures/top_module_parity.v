`default_nettype none
module top_module(
    input [7:0] in,
    output parity
);


    // even parity;
    assign parity = ^in; 



endmodule