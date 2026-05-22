`default_nettype none


module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);


    always @(posedge clk) begin
        if(reset) begin
            q <= 4'h0;
        end
        else begin
            if (~slowena) begin
                q <= q;
            end
            else if (q >= 4'd9) begin
                q <= 4'h0;
            end
            else begin
                q <= q + 4'h1;
            end
        end
    end



endmodule