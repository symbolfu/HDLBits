`default_nettype none
module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q
);



    reg [3:0] count;

    always @(posedge clk) begin
        if(shift_ena) begin
            count <= {count, data};
        end
        else if(count_ena) begin
            count <= count - 1'b1;
        end
        else begin
            count <= count;
        end
    end


    // output 
    assign q = count;



endmodule