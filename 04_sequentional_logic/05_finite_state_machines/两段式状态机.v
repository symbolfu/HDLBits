// 状态转移
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) current_state <= IDLE;
    else current_state <= next_state;
end

// 组合逻辑产生next_state和输出
always @(*) begin
    case(current_state)
        IDLE: if(条件) next_state = NEXT;
        ...
    endcase
    // 输出赋值
end