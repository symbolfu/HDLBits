`default_nettype none
module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);

/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets)
Create a finite state machine to recognize these three sequences:
    011_1110: Signal a bit needs to be discarded (disc).
    0111_1110: Flag the beginning/end of a frame (flag).
    0111_1111...: Error (7 or more 1s) (err).

*/

    parameter NONE = 0,
              ONE = 1,
              TWO = 2,
              THREE = 3,
              FOUR = 4,
              FIVE = 5,
              SIX = 6,
              ERROR = 7,
              DISCARD = 8,
              FLAG = 9;
    
    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if(reset) begin
            state <= NONE;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            NONE: begin
                if(in) begin
                    next_state = ONE;
                end
            end 
            ONE: begin
                if(in) begin
                    next_state = TWO;
                end
                else begin
                    next_state = NONE;
                end
            end             
            TWO: begin
                if(in) begin
                    next_state = THREE;
                end
                else begin
                    next_state = NONE;
                end
            end 
            THREE: begin
                if(in) begin
                    next_state = FOUR;
                end
                else begin
                    next_state = NONE;
                end
            end   
            FOUR: begin
                if(in) begin
                    next_state = FIVE;
                end
                else begin
                    next_state = NONE;
                end  
            end 
            FIVE: begin
                if(in) begin
                    next_state = SIX;
                end
                else begin
                    next_state = DISCARD;
                end   
            end
            SIX: begin
                if(in) begin
                    next_state = ERROR;
                end
                else begin
                    next_state = FLAG;
                end    
            end 
            ERROR: begin
                if(in) begin
                    next_state = ERROR;
                end
                else begin
                    next_state = NONE;
                end       
            end  
            DISCARD: begin
                if(in) begin
                    next_state = ONE;
                end
                else begin
                    next_state = NONE;
                end  
            end 
            FLAG: begin
                if(in) begin
                    next_state = ONE;
                end
                else begin
                    next_state = NONE;
                end 
            end   
        endcase
    end


    // output
    assign disc = state == DISCARD;
    assign flag = state == FLAG;
    assign err = state == ERROR;


endmodule