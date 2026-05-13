`default_nettype none

module top_module(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire        sub,   // show module sub or add
    output wire [31:0] sum
);


    // sub原理： a - b = a + (~b) + 1

    // xor：异或
    wire [31:0] b_comp;
    wire        cout;

    // sub = 0 : b== b_com 
    // sub = 1 : b_com = ~b
    assign b_comp = b ^ {32{sub}};     

    add16 u_add16_1(
        .a(a[15:0]),
        .b(b_comp[15:0]),
        .cin(sub),
        .cout(cout),
        .sum(sum[15:0]),
    );


    
    add16 u_add16_2(
        .a(a[31:16]),
        .b(b_comp[31:16]),
        .cin(cout),
        .cout(),
        .sum(sum[31:16]),
    );




endmodule