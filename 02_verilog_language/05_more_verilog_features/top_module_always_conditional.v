`default_nettype none
module top_module(
    input [7:0] a, b, c, d,
    output [7:0] min
);

    
    wire [7:0] min_1;
    wire [7:0] min_2;

    assign min_1 = a > b ? b : a;
    assign min_2 = c > d ? d : c;

    // output
    assign min = min_1 > min_2 ? min_2 : min_1;


endmodule