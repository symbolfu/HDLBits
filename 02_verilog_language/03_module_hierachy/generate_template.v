


// for-generate

// 循环变量必须用 genvar 声明（不可用 integer）
// begin 后必须命名块（用于层次化引用，如 gen_adder[0].u_adder）
genvar j;  // 必须显式声明genvar类型
generate
    for (j = 0; j < 4; j = j + 1) begin : gen_adder
        adder #(.WIDTH(8)) u_adder (
            .a(a_in[j*8 +: 8]),
            .b(b_in[j*8 +: 8]),
            .sum(sum_out[j*8 +: 8])
        );
    end
endgenerate



// if-generate
// 条件必须是常数（不能依赖动态信号）
localparam USE_DSP = 1;

generate
    if (USE_DSP) begin : dsp_impl
        dsp_multiplier u_mult (.*);
    end else begin : lut_impl
        lut_multiplier u_mult (.*);
    end
endgenerate

// case-generate



localparam ARCH = 2;

generate
    case (ARCH)
        0: begin : arch_slow
            slow_uart uart (.*);
        end
        1: begin : arch_fast
            fast_uart uart (.*);
        end
        default: begin : arch_default
            std_uart uart (.*);
        end
    endcase
endgenerate

