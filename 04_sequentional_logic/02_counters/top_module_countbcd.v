`default_nettype none

module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);

    // Build a 4-digit BCD (binary-coded decimal) counter.
    always @(posedge clk) begin
        if(reset) begin
            q[3:0] <= 4'h0;
        end
        else begin
            if (q[3:0] >= 9) begin
                q[3:0] <= 4'h0;
            end
            else begin
                q[3:0] = q[3:0] + 4'h1;
            end
        end
    end

    assign ena[1] = q[3:0] >= 4'h9 ? 1'b1 : 1'b0;


    always @(posedge clk) begin
        if(reset) begin
            q[7:4] <= 4'h0;
        end
        else if (ena[1]) begin
            if (q[7:4] >= 9) begin
                q[7:4] <= 4'h0;
            end
            else begin
                q[7:4] = q[7:4] + 4'h1;
            end
        end
        else begin
            q[7:4] <= q[7:4];
        end
    end

    assign ena[2] = q[7:4] >= 4'h9 &&  ena[1] ? 1'b1 : 1'b0;


     always @(posedge clk) begin
        if(reset) begin
            q[11:8] <= 4'h0;
        end
        else if (ena[2]) begin
            if (q[11:8] >= 9) begin
                 q[11:8] <= 4'h0;
            end
            else begin
                 q[11:8] =  q[11:8] + 4'h1;
            end
        end
        else begin
             q[11:8] <=  q[11:8];
        end
    end

    assign ena[3] =  q[11:8] >= 4'h9 && ena[2]? 1'b1 : 1'b0;   

     always @(posedge clk) begin
        if(reset) begin
            q[15:12] <= 4'h0;
        end
        else if (ena[3]) begin
            if (q[15:12] >= 1) begin
                q[15:12] <= 4'h0;
            end
            else begin
                q[15:12] =  q[15:12] + 4'h1;
            end
        end
        else begin
            q[15:12] <=  q[15:12];
        end
    end


endmodule