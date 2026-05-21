`default_nettype none

module top_module(
    input clk,
    input [7:0] in,
    output [7:0] pedge
);


    // detect posedge
    reg [7:0] q_reg;

    always @(posedge clk) begin
        q_reg <= in;
    end


    // he output bit should be set the cycle after a 0 to 1 transition occurs.
    // assign pedge = (~q_reg) & in;
    always @(posedge clk) begin
        pedge <= (~q_reg) & in;
    end

endmodule