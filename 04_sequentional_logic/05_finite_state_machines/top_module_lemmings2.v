`default_nettype none
module top_module(
    input clk,
    input areset,     // // Freshly brainwashed Lemmings walk left
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    parameter LEFT = 0,  RIGHT = 1, FALL = 2;
    reg [1:0] state, next_state;
    reg [1:0] save_state, next_save_state;
    

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            save_state <= LEFT;
        end
        else begin
            state <= next_state;
            save_state <= next_save_state;
        end
    end

    always @(*) begin
        next_state = state;
        next_save_state = save_state;

        case (state)
            LEFT: begin
                if( ground == 1'b0) begin
                    next_state = FALL;
                    next_save_state = state;
                end
                else if(bump_left == 1'b1 && bump_right == 1'b1) begin
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
                if( ground == 1'b0) begin
                    next_state = FALL;
                    next_save_state = state;
                end
                else if(bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = ~state;
                end
                else if (bump_left == 1'b1) begin
                    next_state = RIGHT;
                end
                else if(bump_right == 1'b1) begin
                    next_state = LEFT;
                end
            end
            FALL: begin
                if(ground == 1'b1) begin
                    next_state = save_state;
                end
            end
        endcase
    end


    // output 
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;

        case (state)
            LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
            end 
            RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;                
            end
            FALL: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;                
            end
        endcase
    end



endmodule