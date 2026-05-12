`default_nettype none

module top_module(
    input wire      a,
    input wire      b,
    input wire      c,
    input wire      d,
    output wire     out1,
    output wire     out2
);

    // by name on instantiations
    mod_a u_mod_a(
        .in1(a),
        .in2(b),
        .in3(c),
        .in4(d),
        .out1(out1),
        .out2(out2)
    );



endmodule