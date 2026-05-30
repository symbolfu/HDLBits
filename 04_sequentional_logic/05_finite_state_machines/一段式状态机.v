always @(posedge clk or negedge rst_n) begin
    if(!rst_n) current_state <= IDLE;
    else begin
        case(current_state)
            IDLE: if(条件) current_state <= NEXT;
            ...
        endcase
    end
end