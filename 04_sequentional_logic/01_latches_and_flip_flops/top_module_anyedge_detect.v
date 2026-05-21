`default_nettype none
module top_module(
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);


    reg [7:0] q_reg;

    always @(posedge clk) begin
        q_reg <= in;
    end

    always @(posedge clk) begin
        anyedge <= in ^ q_reg;
    end



endmodule