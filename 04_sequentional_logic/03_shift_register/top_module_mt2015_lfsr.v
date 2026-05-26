`default_nettype none
module top_module(
    input [2:0] SW,
    input [1:0] KEY,
    output [2:0] LEDR
);

    // 加载某个value进入开始

    // connect Clock to KEY[0], and L to KEY[1]

    wire d_w_0;
    assign d_w_0 = KEY[1] ? SW[0] : LEDR[2];
    always @(posedge KEY[0]) begin
        LEDR[0] <= d_w_0;
    end

    wire d_w_1;
    assign d_w_1 = KEY[1] ? SW[1] : LEDR[0];
    always @(posedge KEY[0]) begin
        LEDR[1] <= d_w_1;
    end

    wire d_w_2;
    assign d_w_2 = KEY[1] ? SW[2] : LEDR[1] ^ LEDR[2];
    always @(posedge KEY[0]) begin
        LEDR[2] <= d_w_2;
    end


endmodule