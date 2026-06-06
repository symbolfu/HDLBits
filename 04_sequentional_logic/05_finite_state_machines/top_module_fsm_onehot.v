`default_nettype none
module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2    
);

    /*
        Suppose this state machine uses one-hot encoding, 
        where state[0] through state[9] correspond to the states S0 though S9,
        测试激励，并不保证one-hot code
        题目要求的正确做法：通过“观察”状态转移图，直接推导每个次态 bit 的逻辑方程。
        这种方式下，每个次态 bit 只依赖于当前状态的对应 bit 和输入，与当前状态的其他 bit 无关，
        因此即使输入是非独热码，电路也能稳定输出。

        当输入 state（当前状态）不是独热码时，通过"by inspection"方式推导出的 next_state 通常也不是独热码;
    */
    parameter S0 = 0,
              S1 = 1,
              S2 = 2,
              S3 = 3,
              S4 = 4,
              S5 = 5,
              S6 = 6,
              S7 = 7,
              S8 = 8,
              S9 = 9;


    assign next_state[S0] = (state[S0] & ~in) | (state[S1] & ~in) | (state[S2] & ~in) |
                            (state[S3] & ~in) | (state[S4] & ~in) | (state[S7] & ~in) |
                            (state[S8] & ~in) | (state[S9] & ~in);

    assign next_state[S1] = (state[S0] &  in) | (state[S8] &  in) | (state[S9] &  in);
    assign next_state[S2] = (state[S1] &  in);
    assign next_state[S3] = (state[S2] &  in);
    assign next_state[S4] = (state[S3] &  in);
    assign next_state[S5] = (state[S4] &  in);
    assign next_state[S6] = (state[S5] &  in);
    assign next_state[S7] = (state[S6] &  in) | (state[S7] &  in);
    assign next_state[S8] = (state[S5] & ~in);
    assign next_state[S9] = (state[S6] & ~in);        


    assign out1 = state[S8] | state[S9];
    assign out2 = state[S7] | state[S9];

endmodule