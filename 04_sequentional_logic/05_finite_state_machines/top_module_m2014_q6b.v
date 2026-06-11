`default_nettype none
module top_module(
    input [3:1] y,
    input w,
    output Y2
);


    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [3:1] next_state;

    always @(*) begin
        next_state = y;

        case (y)
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
    assign Y2 = next_state[2];



endmodule