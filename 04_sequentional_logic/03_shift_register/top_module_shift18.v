`default_nettype none
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

    // An arithmetic right shift shifts : sign bit of the number
    // 只有右shift需要保留符号位？
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else if(ena) begin
            case (amount)
                // 2'b00: q <= {q[63], q[61:0], 1'b0};
                2'b00: q <= {q[62:0], 1'b0};
                // 2'b01: q <= {q[63], q[54:0], 8'h0};
                2'b01: q <= {q[55:0], 8'h0};
                2'b10: q <= {q[63], q[63], q[62:1]};
                2'b11: q <= {q[63], {8{q[63]}}, q[62:8]};
                default: q <= q;
            endcase
        end
        else begin
            q <= q;
        end
    end


endmodule