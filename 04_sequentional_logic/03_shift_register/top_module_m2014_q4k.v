`default_nettype none
module top_module(
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] q_r;
    always @(posedge clk) begin
        if(!resetn) begin
            q_r <= 4'h0;
        end
        else begin
            q_r <= {q_r[2:0], in}; 
        end
    end

    // output 
    assign out = q_r[3];



endmodule