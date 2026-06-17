`default_nettype none
module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state


    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

    // output
    assign B3_next = state[6];
    // assign S_next = state[3] & ~d || state[9] & ack || state[1] & ~d || state[0] & ~d;
    assign S_next = (state[9] & ack) || ((state[3] | state[0] | state[1]) & ~d);
    assign S1_next = state[0] & d;
    assign Count_next = state[7] || state[8] & ~done_counting;
    assign Wait_next = state[8] & done_counting || state[9] & ~ack;
    assign done = state[9];
    assign counting = state[8];
    assign shift_ena = |state[7:4];


endmodule