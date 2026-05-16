`default_nettype none
module top_module(
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

    reg [100:0] cin_cp;
    // always @(*) begin
    //     cin_cp[0] = cin;
    // end
    // assign cin_cp[0] = cin;


    always @(*) begin
        cin_cp[0] = cin;
        for(int i = 0; i < 100; i++) begin
            {cout[i], sum[i]} = a[i] + b[i] + cin_cp[i];
            cin_cp[i+1] = cout[i];
        end
    end

endmodule