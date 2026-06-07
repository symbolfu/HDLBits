`default_nettype none
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
);

    /*
     each data byte is sent along with a start bit and a stop bit;
     One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). 
     The line is also at logic 1 when nothing is being transmitted (idle).
        error :
            the FSM must wait until it finds a stop bit before attempting to receive the next byte
    */


    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, ERROR = 4;
    reg [2:0] state, next_state;
    reg [2:0] count;

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
                if(~in) begin
                    next_state = START;
                end
                else begin
                    next_state = state;
                end
            end 
            START: begin
                next_state = DATA;
            end 
            DATA: begin
                if(count >='d7 && in) begin
                    next_state = STOP;
                end
                else if (count >='d7 && ~in) begin
                    next_state = ERROR;
                end
            end
            STOP: begin
                if(in) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = START;
                end
            end  
            ERROR: begin
                next_state = in ? IDLE : ERROR;
            end
        endcase
    end

    // counter
    always @(posedge clk) begin
        if(reset) begin
            count <= 1'b0;
        end
        else begin
            if(state == DATA) begin
                count <= count + 1;
            end
            else begin
                count <= 0;
            end
        end
    end

    // wire stop_f;
    // assign stop_f = 

    // output 
    assign done = state == STOP;




endmodule