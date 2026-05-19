`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out
);

/*
  ~a ~c ~d + a ~b ~c + a ~b d + b c d + ~a c ~d + b c d + ~a ~b ~c

   ~a ~c( ~d + ~b) + a ~b (~c + d) + (a + b) c d  + ~a c ~d 


*/

    assign out = ((~a) & (~c) &(~(b&d))) | (a & (~b) &(~c | d)) | ((a | b) & c & d) | ((~a) & c & (~d));



endmodule