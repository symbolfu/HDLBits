`default_nettype none
module top_module(
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);

/*
    Build a finite-state machine that searches for the sequence 1101 in an input bit stream. 
    When the sequence is found, it should set start_shifting to 1, forever, until reset.
*/

    // seq: 1101
    parameter IDLE = 0, S0 = 1, S1 = 2, S2 = 3, DETECT = 4;
    reg [2:0] state, next_state;

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
            IDLE: begin
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
                    next_state = DETECT;
                end
                else begin
                    next_state = IDLE;
                end
            end 
            DETECT: begin
                next_state = DETECT;
            end 
        endcase
    end


    // output 
    assign start_shifting = state == DETECT;


endmodule