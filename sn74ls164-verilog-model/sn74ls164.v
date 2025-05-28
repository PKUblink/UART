module sn74ls164 (
    input wire clk,      // 时钟信号
    input wire clr_n,    // 异步清零信号，低电平有效
    input wire a,        // 串行数据输入 A
    input wire b,        // 串行数据输入 B
    output reg [7:0] q   // 并行输出
);

    always @(posedge clk or negedge clr_n) begin
        if (!clr_n) begin
            // 异步清零
            q <= 8'b0000_0000;
        end else begin
            // 移位操作
            q <= {q[6:0], a & b};
        end
    end

endmodule    