`default_nettype none
module top_module(
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);


    // 1000Hz频率参数1Hz的频率；

    wire [2:0] enable;
    assign enable[0] = 1'b1;
    wire [3:0] Q[3];

    bcdcount u_bcdcount_0(
        .clk(clk),
        .reset(reset),
        .enable(enable[0]),
        .Q(Q[0])
    );

    assign enable[1] = Q[0] >= 4'h9 ? 1'b1 : 1'b0;

    bcdcount u_bcdcount_1(
        .clk(clk),
        .reset(reset),
        .enable(enable[1]),
        .Q(Q[1])
    );

    assign enable[2] = Q[1] >= 4'h9 && enable[1] ? 1'b1 : 1'b0;

    bcdcount u_bcdcount_2(
        .clk(clk),
        .reset(reset),
        .enable(enable[2]),
        .Q(Q[2])
    );

    // assign enable[2] = Q[1] >= 9 ? 1'b1 : 1'b0;

    // always @(posedge clk) begin
    //     if(reset) begin
    //         OneHertz <= 1'b0;
    //     end
    //     else if(Q[2] >= 4'h9 && Q[1] >= 4'h9 && Q[0] >= 4'h9 ) begin
    //         OneHertz <= ~OneHertz;
    //     end
    //     else begin
    //         OneHertz <= OneHertz;
    //     end
    // end

    assign OneHertz = (Q[2] >= 4'h9 && Q[1] >= 4'h9 && Q[0] >= 4'h9 ) ? 1'b1 : 1'b0;

    assign c_enable = enable;

endmodule