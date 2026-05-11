/*
    使用NOT Gate，进行信号取反传递；
*/

module top_module( input in, output out );

	assign out = ~in;  // ~ ： bit inverter;  ! : value inverter

endmodule