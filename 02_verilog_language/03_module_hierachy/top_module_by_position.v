`default_nettype none 

module top_module(
    input wire      a,
    input wire      b,
    input wire      c,
    input wire      d,
    output wire     out1,
    output wire     out2
);

    // by position on instantiations 
    mod_a u_mod_a(out1, out2, a, b, c, d);



endmodule