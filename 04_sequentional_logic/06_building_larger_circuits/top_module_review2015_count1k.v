`default_nettype none
module top_module(
    input clk,
    input reset,
    output [9:0] q
);

/*
    1K counter
*/
    reg [9:0] count;

    always @(posedge clk) begin
        if(reset) begin
            count <= 1'b0;
        end
        else begin
            if(count == 'd999) begin
                count <= 1'b0;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end

    // output 
    assign q = count;

endmodule
