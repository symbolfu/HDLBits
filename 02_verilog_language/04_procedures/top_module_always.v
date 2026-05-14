`default_nettype none


// not test, because hdlbits platform bug
module top_module(
    input wire a,
    input wire b,
    output wire out_assign,
    output reg out_alwaysbloc
);

    assign out_assign = a & b;


    // 在综合后这里是组合逻辑，和上面assign表达式等价；
    // 但是这里的变量out_alwaysbloc必须定义为reg类型，
    // 所以并不会reg类型变量就表示寄存器，这只是verilog语法的规定；
    always @(*) begin
        out_alwaysbloc = a & b;
    end

endmodule