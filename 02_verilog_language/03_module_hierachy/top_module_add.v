`default_nettype none


module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [15:0] sum_1[2];
    wire cout[2];

    add16 u_add16_1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .cout(cout[0]),
        .sum(sum_1[0])
    );

    add16 u_add16_2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(cout[0]),
        .cout(cout[1]),
        .sum(sum_1[1])
    );  


    // output 
    assign sum = {sum_1[1], sum_1[0]};


endmodule