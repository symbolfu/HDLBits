`default_nettype none
module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    // capture when the input signal changes from 1 in one clock cycle to 0 the next
    // "Capture" means that the output will remain 1 until the register is reset (synchronous reset).


    reg [31:0] q_reg;

    always @(posedge clk) begin
        q_reg <= in;
    end

    always @(posedge clk) begin
        if(reset) begin
            out <= 32'h0;
        end
        else begin
            out <= q_reg & (~in) | out;
        end
    end


endmodule