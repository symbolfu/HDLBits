`default_nettype none

module top_module(
    input wire [7:0]        in,
    output wire [31:0]      out
);

    // 符号位扩展
    assign out = {{24{in[7]}}, in};


endmodule