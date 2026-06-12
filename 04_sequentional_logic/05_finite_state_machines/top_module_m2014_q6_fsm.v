`default_nettype none

module top_module(
    input clk,
    input reset,     // synchronous reset
    input w,
    output z
);


parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
reg [2:0] state, next_state;


always @(posedge clk) begin
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
            if(~w) begin
                next_state = B;
            end
        end 
        B: begin
            if(w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end 
        C: begin
            if(w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
        end 
        D: begin
            if(w) begin
                next_state = A;
            end
            else begin
                next_state = F;
            end
        end 
        E: begin
            if(w) begin
                next_state = D;
            end
        end 
        F: begin
            if(w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end 
    endcase
end


    // output
    assign z = state == E || state == F;




endmodule