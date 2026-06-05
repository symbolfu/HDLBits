module top_module(
    input clk,
    input areset,    // 异步复位，复位后向左走
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
); 

    // ---------- 状态定义 ----------
    // 一共7个状态，对应状态图[citation:1][citation:5][citation:9]
    localparam LEFT     = 0,
               RIGHT    = 1,
               FALL_L   = 2,
               FALL_R   = 3,
               DIG_L    = 4,
               DIG_R    = 5,
               SPLAT    = 6;     // 摔死状态

    reg [2:0] state, next_state;
    
    // ---------- 第1部分：掉落计数器与超时标志 ----------
    // 用超时标志可以避免计数器位宽不够的问题，因为旅鼠的掉落时间“没有上限”[citation:5][citation:6]
    reg [4:0] cnt;          // 只需要计到19就够了
    reg timeout;            // 超时标志，标记已经掉落超过20个周期

    // 计数器逻辑：在掉落状态且未超时时递增
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            cnt <= 5'd0;
        end
        else if(state == FALL_L || state == FALL_R) begin
            if(cnt == 5'd19)    // 计满19就不再增加
                cnt <= 5'd19;
            else
                cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= 5'd0;        // 非掉落状态清零
        end
    end

    // 超时标志：只要达到20个周期(计数值为19)，就置位并保持，直到复位
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            timeout <= 1'b0;
        end
        else if(cnt == 5'd19) begin
            timeout <= 1'b1;    // 一旦超时，标志永久生效
        end
        else begin
            timeout <= timeout;
        end
    end

    // ---------- 第2部分：状态寄存器 ----------
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // ---------- 第3部分：次态逻辑 (核心FSM) ----------
    always @(*) begin
        next_state = LEFT; // 默认值，防止锁存
        case(state)
            // 在地面上行走
            LEFT: begin
                if(~ground)          next_state = FALL_L;      // 掉下去了
                else if(dig)         next_state = DIG_L;       // 开始挖地
                else if(bump_left)   next_state = RIGHT;       // 撞墙转向
                else                 next_state = LEFT;
            end
            
            RIGHT: begin
                if(~ground)          next_state = FALL_R;
                else if(dig)         next_state = DIG_R;
                else if(bump_right)  next_state = LEFT;
                else                 next_state = RIGHT;
            end
            
            // 掉落中 (注意：只有落地时才根据超时标志判断是否摔死)
            FALL_L: begin
                if(ground) begin
                    if(timeout)      next_state = SPLAT;       // 摔死[citation:2][citation:7]
                    else             next_state = LEFT;        // 安全着陆
                end
                else                 next_state = FALL_L;      // 继续下落
            end
            
            FALL_R: begin
                if(ground) begin
                    if(timeout)      next_state = SPLAT;
                    else             next_state = RIGHT;
                end
                else                 next_state = FALL_R;
            end
            
            // 挖掘中 (注意：挖着挖着也可能把地挖穿掉下去)
            DIG_L: begin
                if(~ground)          next_state = FALL_L;
                else                 next_state = DIG_L;
            end
            
            DIG_R: begin
                if(~ground)          next_state = FALL_R;
                else                 next_state = DIG_R;
            end
            
            // 摔死状态，永久停留，只能靠复位才能离开
            SPLAT: begin
                next_state = SPLAT;
            end
        endcase
    end

    // ---------- 第4部分：输出逻辑 ----------
    // 采用 assign 语句，简洁明了[citation:1][citation:4]
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALL_L || state == FALL_R);  // 掉落时喊叫[citation:6][citation:8]
    assign digging    = (state == DIG_L  || state == DIG_R);

endmodule