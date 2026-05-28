`default_nettype none
module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);


// the next state of each cell depends only on itself and its two neighbours
    wire [511:0] reg_w;
    reg [511:0] reg_r;
    assign q = reg_r;

    always @(posedge clk) begin
        if(load) begin
            reg_r <= data;
        end
        else begin
            reg_r <= reg_w;
        end
    end

    genvar i;
    generate
        for(i = 0; i < 512; i++) begin: u_cell
            if(i == 0) begin
                assign reg_w[i] =  (reg_r[i] ^ 1'b0) | (~reg_r[i+1] & reg_r[i] & 1'b0); 
            end
            else if(i == 511) begin
                 assign reg_w[i] =  (reg_r[i] ^ reg_r[i-1]) | (~1'b0 & reg_r[i] & reg_r[i-1]);
            end
            else begin
                assign reg_w[i] =  (reg_r[i] ^ reg_r[i-1]) | (~reg_r[i+1] & reg_r[i] & reg_r[i-1]);
            end
        end
    endgenerate



// true table:
// ab~c + a~bc + ~abc + ~ab~c + ~a~bc
// => a(b~c + ~bc)
// => ab^c + ~abc + ~ab^c
// => b ^ c  + ~abc

// 001
//  -11 

endmodule