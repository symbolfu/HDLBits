`default_nettype none
module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);


    always @(posedge clk) begin
        // 综合后，会有8个DFF
        q <= d;
    end


endmodule