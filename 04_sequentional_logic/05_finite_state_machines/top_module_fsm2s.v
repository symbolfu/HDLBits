`default_nettype none
module top_module(
    input clk,
    input reset,
    input j,
    input k,
    output out
);

    //  a Moore state machine

    // using synchronous reset.
    parameter OFF = 0, ON = 1;
    reg state, next_state;


    // state register
    always @(posedge clk) begin
        if(reset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end


    // combinational logic : state change
    always @(*) begin
        next_state = state;

        case (state)
            OFF: begin
                if(j == 1) begin
                    next_state = ON;
                end
            end 
            ON: begin
                if(k == 1) begin
                    next_state = OFF;
                end
            end
        endcase
    end

    // output logic
    always @(*) begin
        out = 1'b1;
        case (state)
            OFF: begin
                out = 1'b0;
            end 
            ON: begin
                out = 1'b1;
            end
        endcase
    end


endmodule