`default_nettype none
module top_module(
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);


    // Create 8 D flip-flops with active high synchronous reset.
    always @(posedge clk) begin
        if(reset) begin
            q <= 8'h00;
        end
        else begin
            q <= d;
        end
    end 


endmodule