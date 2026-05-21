`default_nettype none

module top_module(
    input clk,
    input d,
    output q
);

    wire clk_v;
    reg [1:0] q_reg;
    reg [1:0] counter;

    assign clk_v = ~clk;


    always @(posedge clk) begin
        q_reg[0] <= d;
        counter[0] <= counter[0] + 1'b1; 
    end

    always @(posedge clk_v) begin
        q_reg[1] <= d;
        counter[1] <= counter[1] + 1'b1; 
    end


    // output 
    /*
        01 : 0
        11 : 1
        10 : 0
        00 : 1
    */
    assign q = ^counter ? q_reg[0] : q_reg[1];


endmodule