`default_nettype none

module top_module(
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // assign out_both[0] = in[1] & in[0];
    // assign out_both[1] = in[2] & in[1];
    // assign out_both[2] = in[3] & in[2];
    
    // assign out_any[3] = in[3] | in[2]; 
    // assign out_any[2] = in[2] | in[1]; 
    // assign out_any[1] = in[1] | in[0];

    // assign out_different[0] = in[1] ^ in[0]; 
    // assign out_different[1] = in[2] ^ in[1]; 
    // assign out_different[2] = in[3] ^ in[2]; 
    // assign out_different[3] = in[0] ^ in[3]; 


    genvar i;
    generate
        for(i = 0; i < 100; i++) begin
            if(i != 99) begin
                out_both[i] = in[i+1] & in[i];
                out_any[i+1] = in[i+1] | in[i];
                out_different[i] = in[i+1] ^ in[i];
            end
            else begin
                // out_any[i+1] = in[i+1] | in[i];
                out_different[i] = in[99-i] ^ in[i];
            end
        end
    endgenerate



endmodule