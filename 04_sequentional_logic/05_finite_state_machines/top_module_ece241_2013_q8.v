`default_nettype none
module top_module(
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
);


    // a Mealy-type finite state machine
    //  recognizes the sequence "101" on an input signal named x;
    // that is asserted to logic-1 when the "101" sequence is detected.
    //  only have 3 states in your state machine


    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if(~aresetn) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            S0: begin   // 101 seq
                next_state = x ? S1 : S0;
            end 
            S1: begin
                next_state = x ? S1 : S2;
            end
            S2: begin
                // 收到1则输出并回到S1（重叠检测），收到0则回到S0
                next_state = x ? S1 : S0;
            end
        endcase
    end

    // 输出逻辑（Mealy型：状态+输入共同决定输出）
    always @(*) begin
        z = 1'b0;

        case (state)
            S2: z = x; 
            default: z = 0;
        endcase
    end



endmodule