`default_nettype none
module top_module(
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum
);

    // assign method
    // assign {cout[0], sum[0]} = a[0] + b[0] + cin;
    // assign {cout[1], sum[1]} = a[1] + b[1] + cout[0];
    // assign {cout[2], sum[2]} = a[2] + b[2] + cout[1];


    // generate method
    genvar i;
    generate 
        for(i = 0; i < 3; i = i + 1) begin: full_adder
            if(i == 0) begin
                assign {cout[i], sum[i]} = a[i] + b[i] + cin;
            end
            else begin
                assign {cout[i], sum[i]} = a[i] + b[i] + cout[i-1];
            end
        end 
    endgenerate

endmodule