`default_nettype none

module top_module(
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    genvar i;
    generate
        for(i = 0; i < 100; i = i + 1) begin: out_ooth_any_different
            if(i != 99) begin
                assign out_both[i] = in[i+1] & in[i];
                assign out_any[i+1] = in[i+1] | in[i];
                assign out_different[i] = in[i+1] ^ in[i];
            end
            else begin
                // out_any[i+1] = in[i+1] | in[i];
                assign out_different[i] = in[99-i] ^ in[i];
            end
        end
    endgenerate


endmodule