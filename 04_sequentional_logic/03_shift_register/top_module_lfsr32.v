`default_nettype none
module top_module(
    input clk,
    input reset,
    output [31:0] q
);

    // // Active-high synchronous reset to 5'h1
    // wire [4:1] q_w;
    // assign q_w = q[4:1];
    genvar i;
    generate
        for(i = 0; i < 32; i++) begin: lfsr_1
            if(i == 0) begin
                always @(posedge clk) begin
                    if(reset) begin
                        q[i] <= 1'b1;
                    end
                    else begin
                        q[i] <= q[i + 1] ^ q[0];
                    end
                end
            end
            else if(i == 1 || i == 21)  begin
                always @(posedge clk) begin
                    if(reset) begin
                        q[i] <= 1'b0;
                    end
                    else begin
                        q[i] <= q[i+1] ^ q[0];
                    end
                end
            end
            else if(i == 31) begin
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