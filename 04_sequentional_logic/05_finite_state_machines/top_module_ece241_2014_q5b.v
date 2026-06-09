`default_nettype none
module top_module(
    input clk,
    input areset,
    input x,
    output z
);

    // a Mealy machine
    parameter A = 0, B = 1;
    reg state, next_state;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
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
                if(x) begin
                    next_state = B;
                end
            end
        endcase
    end


    always @(*) begin
        z = 1'b0;

        case (state)
            A: begin
                if(x) begin
                    z = 1;
                end
                else begin
                    z = 0;
                end
            end 
            B: begin
                if(x) begin
                    z = 0;
                end
                else begin
                    z = 1;
                end
            end
        endcase
    end


endmodule