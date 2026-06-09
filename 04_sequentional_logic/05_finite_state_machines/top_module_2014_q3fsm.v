`default_nettype none

module top_module(
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 0, B = 1, 
                B1 = 2, B2 = 3, B3 = 4, B4 =5, B5 = 6, B6 = 7, FAIL = 8, PASS = 9;
    reg[3:0] state, next_state;

    always @(posedge clk) begin
        if(reset) begin
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
                if(s) begin
                    next_state = B;
                end
            end
            B: begin
                if(w) begin
                    next_state = B2;
                end
                else begin
                    next_state = B1;
                end
            end
            B1: begin
                if(w) begin
                    next_state = B4;
                end
                else begin
                    next_state = B3;
                end
            end
            B2: begin
                if(w) begin
                    next_state = B6;
                end
                else begin
                    next_state = B5;
                end
            end
            B3: begin
                next_state = FAIL;
            end
            B4: begin
                if(w) begin
                    next_state = PASS;
                end
                else begin
                    next_state = FAIL;
                end
            end
            B5: begin
                if(w) begin
                    next_state = PASS;
                end
                else begin
                    next_state = FAIL;
                end 
            end
            B6: begin
                if(w) begin
                    next_state = FAIL;
                end
                else begin
                    next_state = PASS;
                end  
            end
            FAIL: begin
                if(w) begin
                    next_state = B2;
                end
                else begin
                    next_state = B1;
                end
            end
            PASS: begin
                if(w) begin
                    next_state = B2;
                end
                else begin
                    next_state = B1;
                end
            end
        endcase
    end

    // output 
    assign z = state == PASS;




endmodule


// couter + fsm method
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 1'b0, B = 1'b1;
    reg state, nstate;
    reg [1:0] cnt_w;      // 统计w=1的次数
    reg [1:0] cnt_cycle;  // 统计3周期内的第几个周期

    // 状态转移逻辑
    always @(*) begin
        case(state)
            A: nstate = s ? B : A;
            B: nstate = B;
            default: nstate = B;
        endcase
    end

    // 状态寄存器
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= nstate;
    end

    // 计数器逻辑
    always @(posedge clk) begin
        if(reset) begin
            cnt_w <= 2'b0;
            cnt_cycle <= 2'b0;
        end
        else if(state == A) begin
            cnt_w <= 2'b0;
            cnt_cycle <= 2'b0;
        end
        else if(state == B) begin
            if(cnt_cycle == 2'd3) begin  // 每3个周期重置一次
                cnt_cycle <= 2'd1;
                cnt_w <= w;
            end
            else begin
                cnt_cycle <= cnt_cycle + 1'b1;
                cnt_w <= cnt_w + w;
            end
        end
    end

    // 输出：在第3个周期结束后（cnt_cycle==3时），检查cnt_w是否等于2
    assign z = (cnt_cycle == 2'd3 && cnt_w == 2'd2);

endmodule

// 状态机 + register
module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output z
);
    parameter A = 0, B1 = 1, B2 = 2, B3 = 3;
    reg [1:0] state, next;
    reg [2:0] w_reg;

    // 状态转移
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end

    always @(*) begin
        case(state)
            A: next = s ? B1 : A;
            B1: next = B2;
            B2: next = B3;
            B3: next = B1;
            default: next = A;
        endcase
    end

    // 存储w值（在时钟上升沿采样）
    always @(posedge clk) begin
        if(reset) begin
            w_reg <= 0;
        end else begin
            case(state)
                B1: w_reg[2] <= w;   // 第1个周期 w -> bit2
                B2: w_reg[1] <= w;   // 第2个周期 w -> bit1
                B3: w_reg[0] <= w;   // 第3个周期 w -> bit0
            endcase
        end
    end

    // 输出逻辑：在B3状态时判断已采集完的3个bit
    // 注意：z要在下一个时钟周期输出，所以组合逻辑或寄存器输出都可
    // 这里用组合逻辑，会在B3期间立即计算出结果，并在下一个时钟上升沿后稳定
    assign z = (state == B3) && 
               (w_reg == 3'b011 || w_reg == 3'b101 || w_reg == 3'b110);