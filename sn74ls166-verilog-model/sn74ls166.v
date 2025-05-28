module sn74ls166 (
    input wire clk,      // 时钟信号
    input wire clr_n,    // 异步清零信号，低电平有效
    input wire sh_ld_n,  // 移位/加载控制信号，低电平时并行加载，高电平时移位
    input wire ser,      // 串行数据输入
    input wire clk_inh,  // 时钟禁止信号，高电平时禁止时钟
    input wire [7:0] p,  // 并行数据输入
    output reg q         // 串行数据输出
);

    reg [7:0] shift_reg; // 8位移位寄存器

    always @(posedge clk or negedge clr_n) begin
        if (!clr_n) begin
            // 异步清零
            shift_reg <= 8'b0000_0000;
        end else if (!clk_inh) begin
            if (!sh_ld_n) begin
                // 并行加载
                shift_reg <= p;
            end else begin
                // 串行移位
                shift_reg <= {shift_reg[6:0], ser};
            end
        end
    end

    // 输出串行数据
    always @(*) begin
        q = shift_reg[7];
    end

endmodule    