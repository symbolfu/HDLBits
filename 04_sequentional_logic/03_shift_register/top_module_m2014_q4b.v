`default_nettype none

module top_module(
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);


/*
    Connect the R inputs to the SW switches,
    clk to KEY[0],
    E to KEY[1],
    L to KEY[2], and
    w to KEY[3].
    Connect the outputs to the red lights LEDR[3:0].
*/

    wire [3:0] w_wire;
    assign w_wire = {KEY[3], LEDR[3:1]};
    genvar i;
    generate
        for(i = 0; i < 4; i++) begin : u_muxdff
            MUXDFF u_muxdff(
                .clk(KEY[0]),
                .w(w_wire[i]),
                .E(KEY[1]),
                .L(KEY[2]),
                .R(SW[i]),
                .Q(LEDR[i])
            );            
        end
    endgenerate


endmodule




module MUXDFF(
    input clk,
    input w, R, E, L,
    output Q
);


    wire [1:0] mux_w;
    wire       q_w;

    assign mux_w[0] = E ? w : Q;
    assign mux_w[1] = L ? R : mux_w[0];

    always @(posedge clk) begin
        Q <= mux_w[1];
    end



endmodule