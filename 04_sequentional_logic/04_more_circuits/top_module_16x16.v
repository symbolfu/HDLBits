`default_nettype none
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);

    /*
        康威生命游戏（Conway's Game of Life）在一个无限的二维矩形网格上进行，每个格子代表一个细胞，
            有两种状态：存活（1）或死亡（0）。
        每个细胞下一时刻的状态由其自身当前状态以及相邻 8 个细胞的存活数决定。
            0-1 neighbour: Cell becomes 0.
            2 neighbours: Cell state does not change.
            3 neighbours: Cell becomes 1.
            4+ neighbours: Cell becomes 0. 


        这个题的核心是如何计算出count           
    */

    reg [255:0] q_next;   //  // 用于存储计算出的下一个状态
    reg [3:0] count;      // // 统计周围活着的邻居数量
    integer i, j;

    always @(*) begin
        for(i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                count = q[((i+1)%16)*16 + (j+1)%16]   // 右下
                    + q[((i+1)%16)*16 + j]          // 下
                    + q[((i+1)%16)*16 + (j+15)%16]  // 左下
                    + q[i*16 + (j+15)%16]           // 左
                    + q[i*16 + (j+1)%16]            // 右
                    + q[((i+15)%16)*16 + (j+15)%16] // 左上
                    + q[((i+15)%16)*16 + j]         // 上
                    + q[((i+15)%16)*16 + (j+1)%16]; // 右上


                // 核心规则：邻居2则保持原状，邻居3则变为1，其余情况变为0
                if(count == 2)
                    q_next[i*16 + j] = q[i*16 + j];
                else if(count == 3)
                    q_next[i*16 + j] = 1'b1;
                else
                    q_next[i*16 + j] = 1'b0;                
            end
        end
    end

    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            q <= q_next;
        end
    end

endmodule