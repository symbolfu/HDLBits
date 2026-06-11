`default_nettype none
module top_module(
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);


// bug module: 反正是会报mismatch，但是目前没有发现问题;
// 怀疑与 always @(*)仿真原理有关系；
    parameter A = 1,
              B = 2,
              C = 4,
              D = 8,
              E = 16,
              F = 32;
    reg [6:1] next_state;

    always @(*) begin

        case (y)
            A: begin
                if(~w) begin
                    next_state = B;
                end
                else begin
                    next_state= A;
                end
            end 
            B: begin
                if(w) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end
            end 
            C: begin
                if(w) begin
                    next_state = D;
                end
                else begin
                    next_state = E;
                end 
            end 
            D: begin
                if(w) begin
                    next_state = A;
                end
                else begin
                    next_state = F;
                end 
            end
            E: begin
                if(w) begin
                    next_state = D;
                end 
                else begin
                    next_state = E;
                end
            end 
            F: begin
                if(w) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end 
            end 
            default: next_state = y;
        endcase
    end


    // output 
    assign Y2 = next_state[2];
    assign Y4 = next_state[4];

endmodule


/*
因为输出 Y2 和 Y4 恰好对应状态 B 和 D 的编码位，
所以只需要找出 “什么条件下次态会是 B” 和 “什么条件下次态会是 D” 即可
*/ 
module top_module (
    input [6:1] y,   // 当前状态，独热码
    input w,         // 输入信号
    output Y2,       // 次态的第2位 (对应状态B)
    output Y4        // 次态的第4位 (对应状态D)
);

    // 根据状态转移图直接写出逻辑表达式
    assign Y2 = y[1] & ~w;          // 仅当在状态A且w=0时，下一个是B
    assign Y4 = w & (y[2] | y[3] | y[5] | y[6]); // 在状态B/C/E/F且w=1时，下一个是D

endmodule
