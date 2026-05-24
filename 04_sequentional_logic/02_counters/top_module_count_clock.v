`default_nettype none

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);


    // 这个题可以定义一个ss的module，mm可以复用ss的module，这样coding更清晰，代码量更少，更不容易出错；

    // reset resets the clock to 12:00 AM
    //  pm is 0 for AM and 1 for PM.
    // clk : 1HZ

    wire [5:0] enable;
    wire [5:0] over_state;


    // ss[3:0]
    assign over_state[0] = (ss[3:0] >= 4'd9) ? 1'b1 : 1'b0; 
    always @(posedge clk) begin
        if(reset) begin
            ss[3:0] <= 4'h0;
        end
        else if(ena) begin
            if(over_state[0]) begin
                ss[3:0] <= 4'h0;
            end
            else begin
                ss[3:0] <= ss[3:0] + 4'h1;
            end
        end
        else begin
            ss[3:0] <= ss[3:0];
        end
    end

    // ss[7:3]
    assign enable[1] = ena && over_state[0];
    assign over_state[1] = (ss[7:4] >= 4'd5) && over_state[0];
    always @(posedge clk) begin
        if(reset) begin
            ss[7:4] <= 4'h0;
        end
        else if(enable[1]) begin
            if(over_state[1]) begin
                ss[7:4] <= 4'h0;
            end
            else begin
                ss[7:4] <= ss[7:4] + 4'h1;
            end
        end
        else begin
            ss[7:4] <= ss[7:4];
        end
    end

    // mm[3:0]
    assign enable[2] = ena & over_state[1]; 
    assign over_state[2] = (mm[3:0] >= 4'h9) && over_state[1];
    always @(posedge clk) begin
        if(reset) begin
            mm[3:0] <= 4'h0;
        end
        else if(enable[2]) begin
            if(over_state[2]) begin
                mm[3:0] <= 4'h0;
            end
            else begin
                mm[3:0] <= mm[3:0] + 4'h1;
            end
        end
        else begin
            mm[3:0] <= mm[3:0];
        end
    end

    // ss[7:3]
    assign enable[3] = ena && over_state[2];
    assign over_state[3] = (mm[7:4] >= 4'd5) && over_state[2];
    always @(posedge clk) begin
        if(reset) begin
            mm[7:4] <= 4'h0;
        end
        else if(enable[3]) begin
            if(over_state[3]) begin
                mm[7:4] <= 4'h0;
            end
            else begin
                mm[7:4] <= mm[7:4] + 4'h1;
            end
        end
        else begin
            mm[7:4] <= mm[7:4];
        end
    end


    assign enable[4] = ena & over_state[3]; 
    assign over_state[4] = (hh[3:0] >= 4'h9) && over_state[3] || (hh[7:4] >= 4'h1 && hh[3:0] >= 4'h2 && over_state[3]);
    always @(posedge clk) begin
        if(reset) begin
            hh[3:0] <= 4'h2;
        end
        else if(enable[4]) begin
            if (hh[7:4] >= 4'h1 && hh[3:0] >= 4'h2 && over_state[3]) begin
                hh[3:0] <= 4'h1;
            end
            else if(hh[3:0] >= 4'h9 && over_state[3]) begin
                hh[3:0] <= 4'h0;
            end
            else begin
                hh[3:0] <= hh[3:0] + 4'h1;
            end
        end
        else begin
            hh[3:0] <= hh[3:0];
        end
    end

    assign enable[5] = ena &  over_state[4];
    assign over_state[5] = hh[7:4] >= 4'h1 && over_state[4];
    always @(posedge clk) begin
        if(reset) begin
            hh[7:4] <= 4'h1;
        end
        else if(enable[5]) begin
            if(over_state[5]) begin
                 hh[7:4] <= 4'h0;
            end
            else begin
                 hh[7:4] <=  hh[7:4] + 4'h1;
            end
        end
        else begin
            hh[7:4] <=  hh[7:4];
        end        
    end


    always @(posedge clk) begin
        if(reset) begin
            pm <= 1'b0;
        end
        else if(hh == 8'h11 && mm == 8'h59  && ss == 8'h59) begin
            pm <= ~pm;
        end
        else begin
            pm <= pm;
        end
    end


endmodule