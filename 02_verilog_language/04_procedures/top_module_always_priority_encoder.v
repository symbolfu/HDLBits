`default_nettype none
module top_module(
    input [3:0] in,
    output reg [1:0] pos
);

    // 学术名称叫优先编码器，
    // 但是我们需要了解其他含义与用途，比如最高位1的位置，进而确定前导0的个数;

    // case method
    always @(*) begin
        case (in)
            // 按照优先级，位置0的输入组合
            4'b0001, 4'b0011, 4'b0101, 4'b0111,
            4'b1001, 4'b1011, 4'b1101, 4'b1111: pos = 2'b00;
            // 按照优先级，位置1的输入组合
            4'b0010, 4'b0110, 4'b1010, 4'b1110: pos = 2'b01;
            // 按照优先级，位置2的输入组合
            4'b0100, 4'b1100: pos = 2'b10;
            // 按照优先级，位置3的输入组合
            4'b1000: pos = 2'b11;
            // 输入为0的情况
            default: pos = 2'b00;
        endcase
    end

    // if-else method
    always @(*) begin
        if(in[0] == 1) begin
            pos = 2'd0;
        end
        else if(in[1] == 1) begin
            pos = 2'd1;
        end
        else if(in[2] == 1) begin
            pos = 2'd2;
        end
        else if(in[3] == 1) begin
            pos = 2'd3;
        end
        else begin
            pos = 2'd0;
        end
    end


endmodule