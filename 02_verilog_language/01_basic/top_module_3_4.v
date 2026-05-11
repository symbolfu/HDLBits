/*
    多个wire connect，通过continuous assignment
*/

module top_module( 
    input a,b,c,
    output w,x,y,z );

    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;
endmodule