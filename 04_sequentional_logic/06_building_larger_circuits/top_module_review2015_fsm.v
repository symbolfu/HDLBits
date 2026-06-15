`default_nettype none
module top_module(
    input clk,
    input reset,      // Synchronous reset
    input data,

    output shift_ena,

    output counting,
    input done_counting,

    output done,
    input ack
);


/*
    When the pattern 1101 is received, 
        the state machine must then assert output shift_ena for exactly 4 clock cycles.

    After that, the state machine asserts its counting output to indicate it is waiting for the counters, 
        and waits until input done_counting is high;

    At that point, the state machine must assert done to notify the user the timer has timed out,
         and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).
*/

    // seq 1101
    parameter IDLE = 0, S0 = 1, S1 = 2, S2 = 3, S3 = 4, SHIFT_ENA = 5, W_COUNT = 6, S_DONE = 7;
    reg [2:0] state, next_state;
    reg [1:0] count;
    wire start_count;

    always @(posedge clk) begin
        if(reset) begin
            count <= 2'b0;
        end
        else if(state == SHIFT_ENA) begin
            if(count >= 'd3) begin
                count <= count;
            end
            else begin
                count <= count + 'd1;
            end
        end
        else begin
            count <= 2'b0;
        end
    end


    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin   // seq: 1101
                if(data) begin
                    next_state = S0;
                end
            end 
            S0: begin
                if(data) begin
                    next_state = S1;
                end
                else begin
                    next_state = IDLE;
                end
            end 
            S1: begin
                if(~data) begin
                    next_state = S2;
                end
                else begin
                    next_state = S1;
                end
            end 
            S2: begin
                if(data) begin
                    next_state <= SHIFT_ENA;
                end
                else begin
                    next_state <= IDLE;
                end
            end 
            SHIFT_ENA: begin
                if(count >= 'd3) begin
                    next_state = W_COUNT;
                end
                else begin
                    next_state = SHIFT_ENA;
                end
            end 
            W_COUNT: begin
                if(done_counting) begin
                    next_state = S_DONE;
                end
                else begin
                    next_state = W_COUNT;
                end
            end 
            S_DONE: begin
                if(ack) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = S_DONE;
                end
            end 
        endcase
    end


    // output 
    assign shift_ena = state == SHIFT_ENA;
    assign counting = state == W_COUNT;
    assign done = state == S_DONE;


endmodule