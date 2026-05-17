`default_nettype none

module top_module(
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output reg[15:0] out
);

    always @(*) begin
        case (sel)
            4'd0: begin out = a; end
            4'd1: begin out = b; end
            4'd2: begin out = c; end
            4'd3: begin out = d; end
            4'd4: begin out = e; end
            4'd5: begin out = f; end
            4'd6: begin out = g; end
            4'd7: begin out = h; end
            4'd8: begin out = i; end
            default: begin out = 16'hFFFF; end
        endcase
    end


endmodule