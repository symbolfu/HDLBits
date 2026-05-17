`default_nettype none
module top_module(
    input in1,
    input in2,
    input in3,
    output out
);


    wire not_xor_1_2;

    assign not_xor_1_2 = ~(in1 ^ in2);
    assign out = not_xor_1_2 ^ in3;


endmodule