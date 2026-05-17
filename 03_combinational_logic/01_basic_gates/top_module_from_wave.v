`default_nettype none


/*
    wave:
        0 0 1
        1 0 0
        0 1 0
        1 1 1

        同或逻辑
*/ 

module top_module(
    input x,
    input y,
    output z
);


    assign z = ~(x ^ y);


endmodule