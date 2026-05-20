`default_nettype none

module top_module(
    input clk,
    input d,
    output reg q
);


    always @(posedge clk) begin
        // 不带复位和使能的D触发器
        //  Clocked always blocks should use non-blocking assignments
        q <= d;
    end


endmodule