`default_nettype none


module top_module(
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum
);

    // provided with a BCD one-digit adder named bcd_fadd
    /*
        module bcd_fadd (
            input [3:0] a,
            input [3:0] b,
            input     cin,
            output   cout,
            output [3:0] sum );    
    */

    reg [99:0] cin_cp;
    reg [99:0] cout_cp;
    always @(*) begin
        cin_cp[0] = cin;
        for (int i = 1; i < 100 ; i++) begin
            cin_cp[i] = cout_cp[i-1];
        end
    end

    genvar i;
    generate
        for(i = 0; i < 100; i = i + 1) begin: bcd_fadd_inst
            bcd_fadd u_bcd_fadd(
                .a(a[4*i+3:4*i]),
                .b(b[4*i+3:4*i]),
                .cin(cin_cp[i]),
                .cout(cout_cp[i]),
                .sum(sum[4*i+3:4*i])
            );
        end
    endgenerate


    // output cout
    assign cout = cout_cp[99];




endmodule


// deepseek search code
module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum
);
    // 1. 定义进位信号数组（100位，对应100个1位BCD加法器的进位输出）
    wire [99:0] carry;
    
    // 2. 使用 generate-for 循环例化100个 bcd_fadd
    genvar i;
    generate
        for(i = 0; i < 100; i = i + 1) begin : bcd_adder_inst
            if(i == 0) begin
                // 第一个加法器：进位输入来自顶层的 cin
                bcd_fadd u_bcd_fadd (
                    .a   (a[3:0] + 4*i),   // 注意：这里不是加法，是位选索引
                    .b   (b[3:0] + 4*i),
                    .cin (cin),
                    .cout(carry[i]),
                    .sum (sum[3:0] + 4*i)
                );
            end
            else begin
                // 后续加法器：进位输入来自前一个加法器的进位输出
                bcd_fadd u_bcd_fadd (
                    .a   (a[3:0] + 4*i),
                    .b   (b[3:0] + 4*i),
                    .cin (carry[i-1]),
                    .cout(carry[i]),
                    .sum (sum[3:0] + 4*i)
                );
            end
        end
    endgenerate
    
    // 3. 最高位的进位输出赋值给 cout
    assign cout = carry[99];
    
endmodule