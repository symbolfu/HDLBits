`default_nettype none

module top_module(
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);


    /*
        The flip-flops must be reset to 0x34 rather than zero.
         All DFFs should be triggered by the negative edge of clk
    */

    always @(negedge clk) begin
        if(reset) begin
            q <= 8'h34;
        end
        else begin
            q <= d;
        end
    end
endmodule