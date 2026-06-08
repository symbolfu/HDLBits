`default_nettype none
module top_module(
    input clk,
    input areset,
    input x,
    output z
);

// Moore state machine
// 实现串行2的补码转换器
// 2’s complement = 2^n −N
/*
    原理：
        从LSB往MSB扫描，遇到第一个1之前，输出=输入；遇到第一个1之后，输出=输入取反
        对 2 的补码表示的数再求一次 2 的补码，得到它的原码（绝对值）


        0               0/1
    ┌─────────┐      ┌──────┐
    │         │      │      │
    ▼         │      ▼      │
   [A] ──1──→ [B] ──1──→ [C]
    │          │           │
    └────0─────┘←────0─────┘
*/
    parameter A = 0, B = 1, C = 2;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            A: next_state = x ? B : A; 
            B: next_state = x ? C : B;
            C: next_state = x ? C : B;
        endcase
    end

    always @(*) begin
        z = 1'b0;

        case (state)
            B: z = 1; 
        endcase
    end



endmodule