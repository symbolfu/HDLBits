/*
输出不仅取决于当前状态，还取决于当前输入:
    状态定义:
        S0 (初始 / 未匹配)
        S1 (got 1)
        S2 (got 10)        

*/


module mealy_101_detector (
    input       clk,
    input       rst_n,
    input       din,
    output reg  dout
);

    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10;

    reg [1:0] state, next_state;

    // 状态寄存器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // 下一状态 + 输出逻辑（Mealy：输出依赖于状态+输入）
    // 通常写成组合逻辑，这样输入变化时输出立即变化
    always @(*) begin
        next_state = state;
        dout = 1'b0;

        case (state)
            S0: begin
                if (din == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (din == 0)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (din == 1) begin
                    next_state = S1;
                    dout = 1'b1;      // ⬅️ Mealy输出：状态S2 + 输入1
                end 
                else begin
                    next_state = S0;
                end
            end

            default: next_state = S0;
        endcase
    end

endmodule