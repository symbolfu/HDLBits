`default_nettype none
module top_module(
    input clk,
    input areset,  //  // Asynchronous reset to state B
    input in,
    output out
);


/*
    状态跳转描述：
        areset   ----->   B
                    out = 1
        B        ---in == 1-->    B
        B        ---in == 0--->  A
                    out = 0
        B        ---in == 1--->  A
        A        ---in == 0--->  B

*/  


    parameter A = 0, B = 1;
    reg state, next_state;

    // state tansfer and register
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end


    // combinational logic : generate next state;
    always @(*) begin
        next_state <= B;
        case (state)
            1'b0: begin
                if(in == 1'b0) begin
                    next_state <= B;
                end
                else begin
                    next_state <= state;
                end
            end 
            1:b1: begin
                if(in == 1'b1) begin
                    next_state <= state;
                end
                else begin
                    next_state <= A;
                end
            end
        endcase
    end


    // output 
    assign out = (state == A) ? 1'b0 : 1'b1;



endmodule