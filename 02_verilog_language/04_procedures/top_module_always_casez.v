`default_nettype none
module top_module(
    input [7:0] in,
    output reg [2:0] pos
);

    // casez中z和?具有相同含义
    always @(*) begin
        casez(in)
            8'bzzzz_zzz1: begin pos = 0; end
            8'bzzzz_zz10: begin pos = 1; end
            8'bzzzz_z100: begin pos = 2; end
            8'bzzzz_1000: begin pos = 3; end
            8'bzzz1_0000: begin pos = 4; end
            8'bzz10_0000: begin pos = 5; end
            8'bz100_0000: begin pos = 6; end
            8'b1000_0000: begin pos = 7; end
            default: begin pos = 0; end
        endcase 
    end



endmodule