`timescale 1ns / 1ps

module tb_sn74ls166;

    reg clk;
    reg clr_n;
    reg sh_ld_n;
    reg ser;
    reg clk_inh;
    reg [7:0] p;
    wire q;

    // 实例化被测试模块
    sn74ls166 uut (
       .clk(clk),
       .clr_n(clr_n),
       .sh_ld_n(sh_ld_n),
       .ser(ser),
       .clk_inh(clk_inh),
       .p(p),
       .q(q)
    );

    // 生成时钟信号
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 测试序列
    initial begin
        // 初始化信号
        clr_n = 1;
        sh_ld_n = 1;
        ser = 0;
        clk_inh = 0;
        p = 8'b0000_0000;
        #10;

        // 异步清零
        clr_n = 0;
        #10;
        clr_n = 1;
        #10;

        // 并行加载
        sh_ld_n = 0;
        p = 8'b1010_1010;
        #10;
        sh_ld_n = 1;
        #10;

        // 串行移位
        ser = 1;
        #10;
        ser = 0;
        #10;
        ser = 1;
        #10;
        ser = 0;
        #10;

        // 时钟禁止
        clk_inh = 1;
        #20;
        clk_inh = 0;
        #10;

        $finish;
    end

endmodule    