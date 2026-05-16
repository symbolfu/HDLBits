`default_nettype none
module top_module(
    input [254:0] in,
    output [7:0] out
);
    localparam LOOP = 255;

    integer i;
    // always @(*) begin
    //     out = 8'h0;
    //     for(i = 0; i < LOOP; i = i + 1) begin
    //         if(in[i] == 1) begin   // 这个比较器是否必须要？
    //             out = out + 8'h1;
    //         end
    //     end
    // end


    always @(*) begin
        out = 0;
        for(int i = 0; i < 255; i++) begin
            out = out + in[i];
        end
    end


endmodule