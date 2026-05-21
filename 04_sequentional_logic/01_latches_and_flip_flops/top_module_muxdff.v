`default_nettype none

module top_module(
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);


    wire d_w;

    assign d_w = L ? r_in : q_in;

    always @(posedge clk) begin
        Q <= d_w;
    end


endmodule