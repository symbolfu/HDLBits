`default_nettype none

module top_module(
    input wire [7:0]    in,
    output wire [7:0]   out
);

    localparam WIDTH = 8;

    integer i;
    always @(*) begin
        for(i = 0; i < WIDTH; i = i + 1) begin
            out[i] = in[WIDTH-i-1];
        end
    end

endmodule