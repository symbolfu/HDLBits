`default_nettype none
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done    
);

/*
The PS/2 mouse protocol sends messages that are three bytes long
 the first byte of each three byte message always has bit[3]=1
 algorithm we'll use is to discard bytes until we see one with bit[3]=1
*/


/*
    IDLE  state :等待第一个byte的bit[3] == 1
    SEND state :  开始发生data，byte1和byte2
    FINISH  state： 发送byte3，并拉高done，同时判断进入IDLE或者START状态
*/


    parameter IDLE = 0, SEND1 = 1,SEND2 = 2, SEND3 = 3;
    reg [1:0] state, next_state;


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
                if(in[3]) begin
                    next_state = SEND1;
                end
            end 
            SEND1: begin
                next_state = SEND2;
            end
            SEND2: begin
                next_state = SEND3;
            end            
            SEND3: begin
                if(in[3]) begin
                    next_state = SEND1;
                end
                else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // OUTPUT 
    assign done = state == SEND3;




endmodule