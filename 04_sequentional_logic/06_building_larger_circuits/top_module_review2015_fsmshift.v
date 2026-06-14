`default_nettype none
module top_module(
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);



/*
    As part of the FSM for controlling the shift register, 
        we want the ability to enable the shift register for exactly 4 clock cycles 
        whenever the proper bit pattern is detected

    Whenever the FSM is reset, assert shift_ena for 4 cycles, then 0 forever (until reset).
*/


    reg [2:0] count;
    always @(posedge clk) begin
        if(reset) begin
            count <= 2'b0;
        end
        else if (shift_ena == 1) begin
            if(count >= 'd3 ) begin
                count <= count;
            end
            else begin
                count <= count + 3'b1;
            end
        end 
        else begin
            count <= count;
        end

    end


    always @(posedge clk) begin
        if(reset) begin
            shift_ena <= 1'b1;
        end
        else begin
            if(count < 'd3) begin
                shift_ena <= 1'b1;
            end
            else begin
                shift_ena <= 1'b0;
            end
        end
    end


endmodule