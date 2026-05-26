`default_nettype none
module top_module(
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z
);

    // design a circuit for an 8x1 memory, 
    /*
        writing to the memory is accomplished by shifting-in bits, 
        and reading is "random access", as in a typical RAM.
    
         extend the circuit to have 3 additional inputs A,B,C and an output Z. The circuit's behaviour should be as follows: 
            when ABC is 000, Z=Q[0], when ABC is 001, Z=Q[1], and so on.
    */

    //  this circuit is called a 3-input look-up-table (LUT)



    reg [7:0] q_r;

    always @(posedge clk) begin
        if(enable) begin
            q_r <= {q_r[6:0], S};   // 8'b1000_0000
        end
        else begin
            q_r <= q_r;
        end
    end


    always @(*) begin
        case ({A,B,C})
            3'b000: Z = q_r[0]; 
            3'b001: Z = q_r[1]; 
            3'b010: Z = q_r[2]; 
            3'b011: Z = q_r[3]; 
            3'b100: Z = q_r[4]; 
            3'b101: Z = q_r[5]; 
            3'b110: Z = q_r[6]; 
            3'b111: Z = q_r[7]; 
            default: Z = q_r[0];
        endcase
    end




endmodule