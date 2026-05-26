`default_nettype none
module top_module(
    input clk,
    input reset,
    output [4:0] q
);

    // // Active-high synchronous reset to 5'h1
    // wire [4:1] q_w;
    // assign q_w = q[4:1];
    genvar i;
    generate
        for(i = 0; i < 5; i++) begin: lfsr_1
            if(i == 0) begin
                always @(posedge clk) begin
                    if(reset) begin
                        q[i] <= 1'b1;
                    end
                    else begin
                        q[i] <= q[i + 1];
                    end
                end
            end
            else if(i == 2) begin
                always @(posedge clk) begin
                    if(reset) begin
                        q[i] <= 1'b0;
                    end
                    else begin
                        q[i] <= q[i+1] ^ q[0];
                    end
                end
            end
            else if(i == 4) begin
                always @(posedge clk) begin
                   if(reset) begin
                        q[i] <= 1'b0;  
                   end 
                   else begin
                        q[i] <= 1'b0 ^ q[0];
                   end
                end
            end
            else begin
                always @(posedge clk) begin
                    if(reset) begin
                        q[i] <= 1'b0;
                    end
                    else begin
                        q[i] <= q[i+1];
                    end
                end                
            end
        end
    endgenerate


endmodule