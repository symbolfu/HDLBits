/*
    或非在verilog中没有对应的运算符，只能通过或运算或非运算完成；
*/

module top_module( 
    input a, 
    input b, 
    output out );
    
    assign out = ~(a | b);

endmodule
