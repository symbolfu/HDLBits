`default_nettype none
module top_module(
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);


// bug：count输出和couting逻辑有问题，需要梳理

/*
    When the pattern 1101 is received, the circuit must then shift in the next 4 bits, 
        most-significant-bit first. 
        These 4 bits determine the duration of the timer delay. I'll refer to this as the delay[3:0]

    After that, the state machine asserts its counting output to indicate it is counting. 
        The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles.
         Also output the current remaining time.
        When the circuit isn't counting, the count[3:0] output is don't-care 

    At that point, the circuit must assert done to notify the user the timer has timed out, 
        and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence


    The circuit should reset into a state where it begins searching for the input sequence 1101.
*/

    // seq 1101
    parameter IDLE = 0, S0 = 1, S1 = 2, S2 = 3, S3 = 4, SHIFT_ENA = 5, W_COUNT = 6, S_DONE = 7;
    reg [2:0] state, next_state;
    reg [4:0] count_v;
    reg [15:0] count_1k;
    wire count_1k_f;
    reg [3:0] delay;
    reg [1:0] count_sample;
    wire count_done;

    always @(posedge clk) begin
        if(reset) begin
            count_1k <= 16'd999;
        end
        else if(state == W_COUNT)begin
            if(count_1k == 'd0) begin
                count_1k <= 16'd999;
            end
            else begin
                count_1k <= count_1k - 16'h1;
            end
        end
        else begin
            count_1k <= 16'd999;
        end
    end

    assign count_1k_f = count_1k == 'd0;

    always @(posedge clk) begin
        if(reset) begin
            count_v  <= 5'd0;
        end
        else if(sample_done) begin
            count_v <= delay + 'd1;
        end
        else if(count_v > 'd0 && count_1k_f) begin
            count_v <= count_v - 'd1;
        end
        else begin
            count_v <= count_v;
        end
    end

    // time out flag
    assign count_done = count_v == 'd1 && count_1k_f;


    always @(posedge clk) begin
        if(reset) begin
            count_sample <= 2'b0;
        end
        else if(state == SHIFT_ENA) begin
            if(count_sample >= 'd3) begin
                count_sample <= count_sample;
            end
            else begin
                count_sample <= count_sample + 'd1;
            end
        end
        else begin
            count_sample <= 2'b0;
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
               if(count_sample >= 'd3) begin
                    next_state = W_COUNT;
                end
                else begin
                    next_state = SHIFT_ENA;
                end
            end 
            W_COUNT: begin
                if(count_done) begin
                    next_state = S_DONE;
                end
            end 
            S_DONE: begin
                if(ack) begin
                    next_state = IDLE;
                end
            end 
        endcase
    end


    // sample delay value
    always @(posedge clk) begin
        if(reset) begin
            delay <= 4'h0;
        end
        else if(state == SHIFT_ENA || (state == SHIFT_ENA && next_state == W_COUNT)) begin
            delay <= {delay, data};
        end
        else begin
            delay <= delay;
        end
    end

    wire sample_done;
    assign sample_done = (state == SHIFT_ENA) && (next_state == W_COUNT) ? 1'b1 : 1'b0;
    // always @(posedge clk) begin
    //     if(reset) begin
    //         sample_done <= 1'b0;
    //     end
    //     else if(state == SHIFT_ENA && next_state == W_COUNT) begin
    //         sample_done <= 1'b1;
    //     end
    //     else begin
    //         sample_done <= 1'b0;
    //     end
    // end

    // output 
    assign count = count_v - 'd1;
    assign counting = state == W_COUNT;
    assign done = state == S_DONE;


endmodule