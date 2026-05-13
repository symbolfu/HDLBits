`default_nettype none

module top_module(
    input wire [31:0]   a,
    input wire [31:0]   b,
    output wire [31:0]  sum
);


    wire cout;
    wire [31:0] sum_t;

    add16 u_add16_1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum_t[15:0]),
        .cout(cout),
    );

    add16 u_add16_2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(cout),
        .sum(sum_t[31:16]),
        .cout(),
    );    


    // output 
    assign sum = sum_t;


endmodule


module add1(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);


    // full-adder
    assign {cout, sum} = a + b + cin;


endmodule