`default_nettype none
module top_module(
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);

    // water level
    // 3 sensor detect : 5-inch interval
    /*
        S3: input flow rate = 0
        s2: 
        s1 : rate = max


        dfr:
            previous level was lower than the current level
            previous level was higher than the current level: open dfr
    */ 

    parameter S3 = 3, S2 = 2, S1 = 1, S0 = 0;
    reg [1:0] state, next_state, pre_state;


    always @(posedge clk) begin
        if(reset) begin
            state <= S0;
            pre_state <= S0;
        end
        else begin
            pre_state <= state;
            state <= next_state; 
        end
    end

    always @(*) begin
        next_state = state;
        
        case (state)
            S0: begin
                if(s == 3'b1) begin
                    next_state = S1;
                end
            end 
            S1: begin
                if(s == 3'b11)  begin
                    next_state = S2;
                end
                else if (s == 3'b0) begin
                    next_state= S0;
                end
            end
            S2: begin
                if(s == 3'b111)  begin
                    next_state = S3;
                end
                else if (s == 3'b1) begin
                    next_state= S1;
                end                
            end
            S3: begin
                if(s == 3'b11)  begin
                    next_state = S2;
                end                
            end
        endcase
    end


    wire enable_dfr;
    // wire drop_flag;
    // assign drop_flag = pre_state > state | drop_flag ? 
    assign enable_dfr = pre_state < state ? 1'b0 : 
                            pre_state > state | enable_dfr ? 1'b1 : 1'b0;

    // output 
    always @(*) begin
        fr3 = 1'b1;
        fr2 = 1'b1;
        fr1 = 1'b1;
        dfr = 1'b1;

        case (state)
            S0: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end 
            S1: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                if(enable_dfr) begin
                    dfr = 1'b1;            
                end
                else begin
                    dfr = 1'b0;
                end                 
            end 
            S2: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                if(enable_dfr) begin
                    dfr = 1'b1;            
                end
                else begin
                    dfr = 1'b0;
                end                 
            end 
            S3: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;  
            end 
        endcase
    end


endmodule