`default_nettype none

module top_module(
    input [99:0] in,
    output [99:0] out
);

    // 如果out type is reg；,但是现代编译器或者综合器可能可以fix；
    // integer i;
    // always @(*) begin
    //     for(i = 0; i < 100; i = i + 1) begin
    //         out[i]= in[99 -i];
    //     end
    // end

    // generate-for: 复制100份assign语句，即连接电路
    genvar i;
    generate
        for(i = 0; i < 100; i = i + 1) begin:reverse
            assign out[i] = in[99 - i];
        end
    endgenerate
    


endmodule