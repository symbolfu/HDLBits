`default_nettype none

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);



/*
    add parity checking to the serial receiver.
    use odd parity: 奇校验
        数据位 + 校验位 中 "1" 的个数必须为奇数；
    Assert the done signal only if a byte is correctly received and its parity check passes
*/

    parameter IDLE = 0, 
              START = 1, 
              DATA = 2, 
              STOP = 3, 
              ERROR = 4,
              PARITY = 5;

    reg [2:0] state, next_state;
    reg [3:0] count;
    reg [7:0] data_reg;
    reg parity_val;



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
                if(count >='d7) begin
                    next_state = PARITY;
                end
            end
            PARITY: begin
                if(in) begin
                    next_state = STOP;
                end
                else if(~in) begin
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
                // PARITY: begin
                //     parity_val <= in;
                // end
                default: begin
                    data_reg <= data_reg;
                end
            endcase
        end
    end

    reg  p_reset;
    wire odd;
    // assign p_reset = ~(next_state == DATA);   // 释放reset，开始计算parity, bug？ 提前将odd reset
    always @(posedge clk) begin  //在开始接收新字节前需要复位奇校验模块
        if(reset) begin
            p_reset <= 1'b0;
        end
        else begin
            case (next_state)   // DATA, parity, ERROR
                IDLE, STOP: p_reset <= 1'b1; 
                default: p_reset <= 1'b0;
            endcase
        end
    end



    parity u_parity(
        .clk(clk),
        .reset(reset | p_reset),
        .in(in),
        .odd(odd)
    );

    // 因为STOP state会拉高p_reset,所以需要对odd打一拍
    reg odd_r;
    always @(posedge clk) begin
        if(reset) begin
            odd_r <= 1'b0;
        end
        else begin
            odd_r <= odd;
        end
    end


    // output 
    // 不采用对比的方式： ~odd == parity_val
    // assign done = (~odd == parity_val) && (state == STOP);
    assign done = (state == STOP) && odd_r;
    assign out_byte = data_reg;


endmodule


// module parity (
//     input clk,
//     input reset,
//     input in,
//     output reg odd);

//     always @(posedge clk)
//         if (reset) odd <= 0;
//         else if (in) odd <= ~odd;

// endmodule