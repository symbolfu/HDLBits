module top_module (
    input clk,
    input reset,
    input data,
    input ack,
    output [3:0] count,
    output counting,
    output done
);

    reg [3:0] state, next_state;
    reg [3:0] d;
    reg [9:0] cnt;
    
    // 状态编码
    localparam  IDLE=0, D1=1, D11=2, D110=3,
                GET0=4, GET1=5, GET2=6, GET3=7,
                RUN=8, STOP=9;

    // 状态转移
    always @(*) begin
        case(state)
            IDLE:   next_state = data ? D1 : IDLE;
            D1:     next_state = data ? D11 : IDLE;
            D11:    next_state = data ? D11 : D110;
            D110:   next_state = data ? GET0 : IDLE;
            GET0:   next_state = GET1;
            GET1:   next_state = GET2;
            GET2:   next_state = GET3;
            GET3:   next_state = RUN;
            RUN:    next_state = (d == 0 && cnt == 0) ? STOP : RUN;
            STOP:   next_state = ack ? IDLE : STOP;
            default:next_state = IDLE;
        endcase
    end

    // 状态寄存器
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end


    // d寄存器
    always @(posedge clk) begin
        if(reset) begin
            d <= 0;
        end else if(state >= GET0 && state <= GET3) begin
            d <= {d[2:0], data};
        end else if(state == RUN && cnt == 0) begin
            d <= d - 1;
        end
    end

    // cnt计数器
    always @(posedge clk) begin
        if(reset) begin
            cnt <= 999;
        end else if(state == RUN) begin
            cnt <= (cnt == 0) ? 999 : cnt - 1;
        end else begin
            cnt <= 999;
        end
    end

    // 输出
    assign count = (state == RUN) ? d : 0;
    assign counting = (state == RUN);
    assign done = (state == STOP);

endmodule