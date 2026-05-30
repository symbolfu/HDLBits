// 时序逻辑：状态寄存
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) current_state <= IDLE;
    else current_state <= next_state;
end

// 组合逻辑：next_state产生
always @(*) begin
    case(current_state)
        IDLE: if(条件) next_state = NEXT;
        else next_state = IDLE;
        ...
    endcase
end

// 时序逻辑：输出（寄存器输出）
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) out <= 0;
    else begin
        case(current_state)
            IDLE: out <= 某值;
            ...
        endcase
    end
end