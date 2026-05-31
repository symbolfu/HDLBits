`default_nettype none
module top_module(
    input clk,
    input areset,
    input j,
    input k,
    output out
);

/*
     a Moore state machine
*/

    parameter OFF = 0, ON = 1;
    reg state, next_state;


    // state change
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end

    // state transition logic
    always @(*) begin
        next_state = state;

        case (state)
            OFF: begin
                if(j == 1) begin
                    next_state = ON;
                end
            end 
            ON: begin
                if(k == 1) begin
                    next_state = OFF;
                end
            end
        endcase
    end



    // output 
    always @(*) begin
        out = 1'b0;
        case (state)
            OFF: begin
                out = 1'b0;
            end 
            ON: begin
                out = 1'b1;
            end
        endcase
    end


endmodule