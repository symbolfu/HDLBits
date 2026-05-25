`default_nettype none
module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    // ena[1:0]: Chooses whether and which direction to rotate.
    /*
        2'b01 rotates right by one bit
        2'b10 rotates left by one bit
        2'b00 and 2'b11 do not rotate.
    */

    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};
                2'b10: q <= {q[98:0], q[99]};
                default: q <= q;
            endcase
        end
    end



endmodule