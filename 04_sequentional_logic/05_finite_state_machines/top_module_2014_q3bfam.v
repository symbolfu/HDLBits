`default_nettype none
module top_module(
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);


    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if(reset) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            S0: begin
                if(x) begin
                    next_state = S1;
                end
            end 
            S1: begin
                if(x) begin
                    next_state = S4;
                end
            end 
            S2: begin
                if(x) begin
                    next_state = S1;
                end
            end 
            S3: begin
                if(x) begin
                    next_state = S2;
                end
                else begin
                    next_state = S1;
                end
            end 
            S4: begin
                if(x) begin
                    next_state = S4;
                end
                else begin
                    next_state = S3;
                end
            end 
        endcase
    end


    // output 
    assign z = state == S3 || state == S4;

endmodule