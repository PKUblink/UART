module sn74ls163a (
    input wire clk,      // 时钟信号
    input wire clr_n,    // 同步清零信号，低电平有效
    input wire ld_n,     // 同步置数信号，低电平有效
    input wire enp,      // 计数使能 P
    input wire ent,      // 计数使能 T
    input wire [3:0] d,  // 并行数据输入
    output reg [3:0] q,  // 计数器输出
    output wire rco      // 进位输出
);

    // 计算进位输出
    assign rco = (q == 4'b1111) & ent;

    always @(posedge clk) begin
        if (!clr_n) begin
            // 同步清零
            q <= 4'b0000;
        end else if (!ld_n) begin
            // 同步置数
            q <= d;
        end else if (enp & ent) begin
            // 计数
            q <= q + 1;
        end else begin
            // 保持
            q <= q;
        end
    end

endmodule    