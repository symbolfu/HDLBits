`default_nettype none

module top_module(
    input d,
    input ena,
    output reg q
);


    // generate latch
    always @(*) begin
        if(ena) begin
            q = d;
        end
    end


endmodule