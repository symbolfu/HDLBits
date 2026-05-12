`default_nettype none

module top_module(
    input clk,
    input [7:0] d,
    input [1:0] sel,
    output [7:0] q
);


    wire [7:0] dff[0:2];

    my_dff8 u_dff8_1(.clk(clk), .d(d), .q(dff[0]));
    my_dff8 u_dff8_2(.clk(clk), .d(dff[0]), .q(dff[1]));
    my_dff8 u_dff8_3(.clk(clk), .d(dff[1]), .q(dff[2]));

    always @(*) begin
        case(sel)
            0:  q = d;
            1:  q = dff[0];
            2:  q = dff[1];
            3:  q = dff[2];
            default:  q = 8'hxx;
        endcase
    end


endmodule