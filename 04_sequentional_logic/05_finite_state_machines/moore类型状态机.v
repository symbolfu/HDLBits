/*
状态定义（输出只与状态有关）
    S0 (idle) → dout = 0
    S1 (got 1) → dout = 0
    S2 (got 10) → dout = 0
    S3 (got 101) → dout = 1    
*/


module moore_101_detector (
    input       clk,
    input       rst_n,
    input       din,
    output reg  dout
);

    // 状态编码
    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10,
               S3 = 2'b11;

    reg [1:0] state, next_state;

    // 状态转移（时序逻辑）
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // 下一状态逻辑（组合逻辑）
    always @(*) begin
        next_state = state;
        case (state)
            S0: next_state = (din == 1) ? S1 : S0;
            S1: next_state = (din == 0) ? S2 : S1;
            S2: next_state = (din == 1) ? S3 : S0;
            S3: next_state = (din == 1) ? S1 : S2;
            default: next_state = S0;
        endcase
    end




    // 输出逻辑（Moore：仅取决于当前状态）
    always @(*) begin
        case (state)
            S3: dout = 1;
            default: dout = 0;
        endcase
    end

endmodule