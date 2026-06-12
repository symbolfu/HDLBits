module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 


    // 有点捂手协议的意味
    // req   ----  grant



    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state;


    always @(posedge clk) begin
        if(~resetn) begin
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
                if(r[1]) begin
                    next_state = B;
                end 
                else if(r[2:1] == 2'b10) begin
                    next_state = C; 
                end
                else if(r[3:1] == 3'b100) begin
                    next_state = D;
                end 
            end 
            B: begin
                if(r[1] == 1'b0) begin
                    next_state = A;
                end
            end 
            C: begin
                if(r[2] == 1'b0) begin
                    next_state = A;
                end
            end 
            D: begin
                if(r[3] == 1'b0) begin
                    next_state = A;
                end
            end 
        endcase
    end


    // output 
    assign g[1] = state == B;
    assign g[2] = state == C;
    assign g[3] = state == D;

endmodule