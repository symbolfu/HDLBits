`default_nettype none
module top_module(
    input clk,
    input reset,
    input in,
    output reg out
);

    parameter A = 1, B = 0;

    reg present_state, next_state;

    // 一段式状态机
    always @(posedge clk) begin
        if(reset) begin
            present_state <= B;
            out <= 1'b1;
        end
        else begin
            case(present_state) 
                // state transition logic
                A: begin
                    if(in == 1'b1) begin
                        next_state = present_state;
                    end
                    else begin
                        next_state = B;
                    end
                end
                B: begin
                    if(in == 1'b1) begin
                        next_state = present_state;
                    end
                    else begin
                        next_state = A;
                    end
                end
                default: begin
                    if(in == 1'b1) begin
                        next_state = present_state;
                    end
                    else begin
                        next_state = B;
                    end                    
                end
            endcase

            // state flip-flops
            present_state = next_state;

            // fill in output logic
            case (present_state)
                A: out = 1'b0;
                B: out = 1'b1;
                default: out = 1'b0;
            endcase
        end
    end



endmodule