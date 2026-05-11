`default_nettype none

module top_module(
    input a, b, c, d, e,
    output wire [24:0]  out
);


    wire[24:0] operator_1;
    wire [24:0] operator_2;

    assign operator_1 = {{5{~a}}, {5{~b}}, {5{~c}}, {5{~d}}, {5{~e}}};
    assign operator_2 = {{5{a, b, c, d, e}}};

    assign out = operator_1 ^ operator_2;

endmodule
