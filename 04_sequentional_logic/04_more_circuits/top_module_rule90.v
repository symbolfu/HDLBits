`default_nettype none
module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);


 // Rule 90 is a one-dimensional cellular automaton with interesting properties.
 // the next state of each cell is the XOR of the cell's two current neighbours
 
 reg [511:0] cell_r;
 wire [511:0] cell_w;

 always @(posedge clk) begin
    if(load) begin
        cell_r <= data;
    end
    else begin
        cell_r <= cell_w;
    end
 end

 
 genvar i;
 generate
    for(i = 0; i < 512; i++) begin : ca_block
        if(i == 0) begin
            assign cell_w[i] = cell_r[i+1] ^ 1'b0;
        end
        else if(i == 511) begin
            assign cell_w[i] = 1'b0 ^ cell_r[i - 1];
        end
        else begin
            assign cell_w[i] = cell_r[i + 1] ^ cell_r[i - 1];
        end
    end
 endgenerate

 assign q = cell_r;


endmodule