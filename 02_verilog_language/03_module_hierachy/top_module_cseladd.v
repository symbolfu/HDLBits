`default_nettype none

module top_module(
    input wire [31:0]   a,
    input wire [31:0]   b,
    output wire [31:0]  sum
);

//  One improvement is a carry-select adder, shown below. 
//  The first-stage adder is the same as before, 
//  but we duplicate the second-stage adder, one assuming carry-in=0 and one assuming carry-in=1, 
//  then using a fast 2-to-1 multiplexer to select which result happened to be correct.


    wire [15:0] sum_level_2[2];
    wire [15:0] sum_level_2_mux;
    wire [15:0] sum_level_1;
    wire        cout_level_1;

    // level 1 compute
    add16 u_add16_1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum_level_1),
        .cout(cout_level_1),
    );    


    // level2 compute： 提取计算，应该cout只有两种可能,通过level1的cout做结果选择

    add16 u_add16_2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(sum_level_2[0]),
        .cout(),
    );

    add16 u_add16_3(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(sum_level_2[1]),
        .cout(),
    );

    // level 2 result mux
    assign sum_level_2_mux = (cout_level_1 == 1'b1) ? sum_level_2[1] : sum_level_2[0];


    // output
    assign sum = {sum_level_2_mux, sum_level_1};


endmodule