`default_nettype none
module top_module(
    input clk,
    input areset,   // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    parameter LEFT = 0, RIGHT = 1;
    reg state, next_state;

/*
    if a Lemming is bumped on the left, it will walk right. 
    If it's bumped on the right, it will walk left. 
    If it's bumped on both sides at the same time, it will still switch directions

    Implement a Moore state machine with two states,
*/

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            LEFT: begin
                if(bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = ~state;
                end
                else if (bump_left == 1'b1) begin
                    next_state = RIGHT;
                end
                else if(bump_right == 1'b1) begin
                    next_state = LEFT;
                end
            end 
            RIGHT: begin
                if(bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = ~state;
                end
                else if (bump_left == 1'b1) begin
                    next_state = RIGHT;
                end
                else if(bump_right == 1'b1) begin
                    next_state = LEFT;
                end
            end
        endcase
    end


    // output 
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;

        case (state)
            LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;                
            end 
            RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;                
            end
        endcase
    end



endmodule