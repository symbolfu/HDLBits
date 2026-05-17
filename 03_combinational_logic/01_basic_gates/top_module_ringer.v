`default_nettype none


module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // 逻辑与
    assign ringer = (vibrate_mode == 1'b0 && ring == 1'b1) ? 1'b1 : 1'b0;
    assign motor = (vibrate_mode == 1'b1 && ring == 1'b1) ? 1'b1 : 1'b0;


endmodule