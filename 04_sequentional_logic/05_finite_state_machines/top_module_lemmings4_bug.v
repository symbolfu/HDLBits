`default_nettype none
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging    
);

    // Falling for 20 cycles is survivable:
    // Falling for 21 cycles causes splatter:
    //  If a Lemming falls for too long then hits the ground, it can splatter. 
    /*
         if a Lemming falls for more than 20 clock cycles then hits the ground, 
         it will splatter and cease walking, falling, or digging (all 4 outputs become 0), forever (Or until the FSM gets reset).
    */


    parameter LEFT = 0, RIGHT = 1, FALL = 2, DIG = 3, SPLATTER = 4;
    reg [2:0] state, next_state;
    reg [2:0] save_state, next_save_state;
    reg [4:0] count;

    // counter groud
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            count <= 5'b0;
        end
        else if(~ground) begin
            count <= count + 5'b1;
        end 
        else begin
            count <= 5'b0;
        end
    end 

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
                else if (dig == 1'b1) begin
                    next_state = DIG;
                    next_save_state = state;
                end
                else if(bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = state == RIGHT ? LEFT : RIGHT;
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
                else if (dig == 1'b1) begin
                    next_state = DIG;
                    next_save_state = state;
                end
                else if(bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = state == RIGHT ? LEFT : RIGHT;
                end
                else if (bump_left == 1'b1) begin
                    next_state = RIGHT;
                end
                else if(bump_right == 1'b1) begin
                    next_state = LEFT;
                end
            end
            FALL: begin
                if(ground == 1'b1 && count >= 5'd21) begin
                    next_state = SPLATTER;
                end
                else if(ground == 1'b1) begin
                    next_state = save_state;
                end
            end
            DIG: begin
                if(ground == 1'b0) begin
                    next_state = FALL;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
        endcase
    end        


    // output 
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (state)
            LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end 
            RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;  
                digging = 1'b0;              
            end
            FALL: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;  
                digging = 1'b0;              
            end
            DIG: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;  
                digging = 1'b1;                   
            end
            SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;  
                digging = 1'b0;  
            end
        endcase
    end


endmodule

//
