`default_nettype none

module top_module(
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum
);


    wire [3:0] cout_temp;


    genvar i;
    generate
        for(i = 0; i < 4; i++) begin: bcd_fadd
            if(i == 0) begin
                bcd_fadd u_bcd_fadd(
                    .a(a[4*i +: 4]),
                    .b(b[4*i +: 4]),
                    .cin(cin),
                    .cout(cout_temp[i]),
                    .sum(sum[4*i +: 4])
                );                
            end
            else begin
                bcd_fadd u_bcd_fadd(
                    .a(a[4*i +: 4]),
                    .b(b[4*i +: 4]),
                    .cin(cout_temp[i-1]),
                    .cout(cout_temp[i]),
                    .sum(sum[4*i +: 4])
                );                  
            end

        end
    endgenerate

    assign cout = cout_temp[3];



endmodule