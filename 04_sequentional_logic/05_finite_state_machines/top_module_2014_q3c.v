module top_module (
    input clk,           // 虽然后面没用到，但模块声明里有
    input [2:0] y,       // 当前状态
    input x,             // 输入
    output Y0,           // 下一状态的最低位
    output z             // 输出z
);
    // 定义状态参数
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    reg [2:0] next_state;

    // 组合逻辑：根据当前状态y和输入x计算下一状态
    always @(*) begin
        case (y)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default: next_state = S0;
        endcase
    end

    // 组合逻辑：输出Y0是next_state的第0位
    assign Y0 = next_state[0];
    // 组合逻辑：z在状态S3或S4时为1
    assign z = (y == S3) | (y == S4);

endmodule