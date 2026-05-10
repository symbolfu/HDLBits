module top_module (
    input           a,
    input           b,
    input           c,
    input           d,
    output          out,
    output          out_n
);

wire a_b;
wire c_d;
wire a_d_or;

assign a_b      = a & b;
assign c_d      = c & d;
assign a_d_or   = a_b | c_d;


// output
assign out      = a_d_or;
assign out_n    = ~a_d_or;

endmodule