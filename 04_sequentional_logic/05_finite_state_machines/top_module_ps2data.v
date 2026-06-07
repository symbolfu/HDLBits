`default_nettype none
module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done    
);


    parameter IDLE = 0, SEND1 = 1,SEND2 = 2, SEND3 = 3;
    reg [1:0] state, next_state;
    reg [23:0] data_reg;

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

    always @(posedge clk) begin
        if(reset) begin
            data_reg <= 0;
        end
        else begin
            case (next_state)
                IDLE: begin
                    data_reg <= data_reg;
                end 
                SEND1, SEND2,SEND3: begin
                    data_reg <= {data_reg, in};
                end
                default:  begin
                    data_reg <= data_reg;
                end
            endcase
        end
    end


    // output 
    assign done = state == SEND3;
    assign out_bytes = done ? data_reg : 0;




endmodule