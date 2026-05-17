`default_nettype none
module top_module(
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // error
    // assign out = in[sel*4+3:sel*4];
    assign out = in[4*sel+: 4];

endmodule