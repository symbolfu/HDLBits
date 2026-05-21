`default_nettype none
module top_module(
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