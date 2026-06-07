`default_nettype none
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, ERROR = 4;
    reg [2:0] state, next_state;
    reg [2:0] count;
    reg [7:0] data_reg;

    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if(~in) begin
                    next_state = START;
                end
                else begin
                    next_state = state;
                end
            end 
            START: begin
                next_state = DATA;
            end 
            DATA: begin
                if(count >='d7 && in) begin
                    next_state = STOP;
                end
                else if (count >='d7 && ~in) begin
                    next_state = ERROR;
                end
            end
            STOP: begin
                if(in) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = START;
                end
            end  
            ERROR: begin
                next_state = in ? IDLE : ERROR;
            end
        endcase
    end

    // counter
    always @(posedge clk) begin
        if(reset) begin
            count <= 1'b0;
        end
        else begin
            if(state == DATA) begin
                count <= count + 1;
            end
            else begin
                count <= 0;
            end
        end
    end

    // data path
    always @(posedge clk) begin
        if(reset) begin
            data_reg <= 8'h0;
        end
        else begin
            case (next_state)    
            // 使用next_state和状态机保持同步，
            // 如果使用state，则采样就会慢一拍，需要在start状态进行判断；
            // 采样时机；这里想使用state采样data，就需要上面状态机跳转到data状态，但是此时第一排数据已经无法采集了；
                DATA: begin
                    data_reg <= {in, data_reg[7:1]};
                end
                default: begin
                    data_reg <= data_reg;
                end
            endcase
        end
    end

    // output 
    assign done = state == STOP;
    assign out_byte = data_reg;


endmodule