`default_nettype none


module top_module(
    input wire clk,
    input wire d,
    output wire q
);

    localparam LOOP_LENTH = 3;
    wire[2:0] dff;


    // tradition method
    my_dff u_dff_1(.clk(clk), .d(d), .q(dff[0]));
    my_dff u_dff_2(.clk(clk), .d(dff[0]), .q(dff[1]));
    my_dff u_dff_3(.clk(clk), .d(dff[1]), .q(dff[2]));


    // output 
    assign q = dff[2];



endmodule