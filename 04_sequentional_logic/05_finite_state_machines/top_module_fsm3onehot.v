`default_nettype none
module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

/*
  Derive state transition and output logic equations by inspection :
      Use the following one-hot state encoding: 
        A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000.


*/

    parameter A = 0, B = 1, C = 2, D = 3;


    assign next_state[A] = (state[A] & ~in) | (state[C] & ~in);
    assign next_state[B] = (state[A] & in)  | (state[B] & in) | (state[D] & in);
    assign next_state[C] = (state[B] & ~in) | (state[D] & ~in);
    assign next_state[D] = (state[C] & in);

    assign out = state[D] ? 1'b1 : 1'b0;

endmodule