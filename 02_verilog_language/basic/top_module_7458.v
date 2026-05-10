/*
    The 7458 is a chip with four AND gates and two OR gates；
    
*/


module top_module (
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y
);


    wire p2_ab;
    wire p2_cd;
    wire p1_abc;
    wire p1_def;

    assign p2_ab = p2a & p2b;
    assign p2_cd = p2c & p2d;

    assign p1_abc = p1a & p1b & p1c;
    assign p1_def = p1d & p1e & p1f;


    // output
    assign p2y = p2_ab | p2_cd;
    assign p1y = p1_abc | p1_def;

endmodule