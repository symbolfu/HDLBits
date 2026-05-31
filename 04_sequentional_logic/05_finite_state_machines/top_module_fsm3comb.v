`default_nettype none

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
);

    //a Moore state machine
    // Implement only the state transition logic and output logic 

    parameter A = 0, B = 1, C = 2, D = 3;

    // state transition logic
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
                if(in == 0) begin
                    next_state = A;
                end
                else begin
                    next_state = D;
                end
            end
            D: begin
                if(in == 0) begin
                    next_state = C;
                end
                else begin
                    next_state = B;
                end                
            end
        endcase
    end


    // output logic
    always @(*) begin
        out = 1'b0;
        case (state)
            A, B, C: begin
                out = 1'b0;
            end 
            D: begin
                out = 1'b1;
            end
        endcase
    end    

endmodule