`default_nettype none
module top_module(
    input clk,
    input in,
    input reset,
    output out
);

    //  a Moore state machine
    //  a synchronous reset
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state;


    always @(posedge clk ) begin
        if(reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end 

    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                if(in == 1) begin
                    next_state = B;
                end
            end 
            B: begin
                if(in == 0) begin
                    next_state = C;
                end
            end
            C: begin
                if(in == 1) begin
                    next_state = D;
                end
                else begin
                    next_state = A;
                end
            end
            D: begin
                if( in == 1) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
            end
        endcase
    end


    // output 
    always @(*) begin
        out = 1'b0;
        case (state)
            D: begin
                out = 1'b1;
            end
        endcase
    end

endmodule