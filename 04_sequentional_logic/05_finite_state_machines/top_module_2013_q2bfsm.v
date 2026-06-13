`default_nettype none

module top_module(
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
);


/*
The FSM has to work as follows:
    1. As long as the reset input is asserted, the FSM stays in state A;
    2. When the reset signal is de-asserted, 
        then after the next clock edge the FSM has to set the output f to 1 for one clock cycle.
    3. the FSM has to monitor the x input:
        1) When x has produced the values 1, 0, 1 in three successive clock cycles, 
            then g should be set to 1 on the following clock cycle;
        2) While maintaining g = 1 the FSM has to monitor the y input:
            1)  If y has the value 1 within at most two clock cycles, 
                then the FSM should maintain g = 1 permanently (that is, until reset)
            2)  if y does not become 1 within two clock cycles, 
                then the FSM should set g = 0 permanently (until reset)


    状态分析：
        A状态：
            复位后的初始状态；
        B状态：
            复位后的第一个cycel，用于拉高输出output f for one clk cycle；
            跳入到C状态
        C状态：
            x = 1；
        D状态：
            x = 0;
        E状态：
            x = 1；
        F状态：
            拉高g = 1 ,一直
            同时开始检测y输出；y = 1则跳入G状态
        G状态：
            拉高g；
            同时一直保持在G状态；
        H状态：
            检测y输出；y = 1则跳入G状态；
            否则，跳入I状态
        I状态：
            拉低g;
            同时一直保持在I状态；
*/


    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6, H = 7, I = 8;
    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if(~resetn) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            A: begin
                next_state  = B;
            end 
            B: begin
                next_state = C;
                // if(x) begin
                //     next_state = D;
                // end
                // else begin
                //     next_state = C;
                // end
            end 
            C: begin    // detect x seq
                if(x) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end
            end 
            D: begin
                if(~x) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end 
            E: begin
                if(x) begin
                    next_state = F;
                end
                else begin
                    next_state = C;
                end
            end 
            F: begin
                if(y) begin
                    next_state = G;
                end
                else begin
                    next_state = H;
                end
            end 
            G: begin
                next_state = G;
            end 
            H: begin
                if(y) begin
                    next_state = G;
                end
                else begin
                    next_state = I;
                end
            end 
            I: begin
                next_state = I;
            end 
        endcase
    end


    // output 
    assign f = state == B;
    assign g = state == F || state == H || state == G;


endmodule