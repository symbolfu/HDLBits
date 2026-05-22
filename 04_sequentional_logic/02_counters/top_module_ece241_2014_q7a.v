`default_nettype none
module top_module(
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);


    always @(posedge clk) begin
        if(reset) begin
            Q <= 4'h1;
        end
        else begin
            if (enable) begin
                if (Q >=4'd12) begin
                    Q <= 4'h1;
                end
                else begin
                    Q <= Q + 4'h1;
                end
            end
            else begin
                Q <= Q;
            end
        end
    end


    wire load_w;
    reg d_w;


    assign load_w = reset | ( enable & (Q >=4'd12));
    assign c_d = 4'h1;


    count4 u_count4(
        .clk(clk),
        .enable(enable),
        .load(load_w),
        .d(c_d),
        .Q()
    );



    // output 
    assign c_enable = enable;
    assign c_load = load_w;


endmodule