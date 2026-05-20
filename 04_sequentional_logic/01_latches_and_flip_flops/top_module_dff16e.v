`default_nettype none

module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    /*
        The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle. 
        resetn is a synchronous, active-low reset.

    */
    always @(posedge clk) begin
        if(~resetn) begin
            q <= 16'h0000;
        end
        else begin
            case(byteena)
                2'b00: begin q <= q; end   // 会转化为EN-DFF
                2'b01: begin q[7:0] <= d[7:0] ; end
                2'b10: begin q[15:8] <= d[15:8] ; end
                2'b11: begin q <= d; end
                default: begin q <= q; end
            endcase
        end 
    end


endmodule