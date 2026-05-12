`default_nettype none

module top_module(
    input wire      a,
    input wire      b,
    output wire     out
);


    mod_a u_mod_a(
        .in1(a),
        .in2(b),
        .out(out)
    );

endmodule