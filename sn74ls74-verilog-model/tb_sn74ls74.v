`timescale 1ns / 1ps

module tb_sn74ls74;

    reg clk1;
    reg d1;
    reg clr1_n;
    reg pr1_n;
    wire q1;
    wire q1_n;

    reg clk2;
    reg d2;
    reg clr2_n;
    reg pr2_n;
    wire q2;
    wire q2_n;

    // 实例化被测试模块
    sn74ls74 uut (
       .clk1(clk1),
       .d1(d1),
       .clr1_n(clr1_n),
       .pr1_n(pr1_n),
       .q1(q1),
       .q1_n(q1_n),
       .clk2(clk2),
       .d2(d2),
       .clr2_n(clr2_n),
       .pr2_n(pr2_n),
       .q2(q2),
       .q2_n(q2_n)
    );

    // 生成时钟信号
    initial begin
        clk1 = 0;
        clk2 = 0;
        forever #5 clk1 = ~clk1;
    end

    initial begin
        forever #5 clk2 = ~clk2;
    end

    // 测试序列
    initial begin
        // 初始化信号
        d1 = 0; clr1_n = 1; pr1_n = 1;
        d2 = 0; clr2_n = 1; pr2_n = 1;
        #10;

        // 异步复位第一个触发器
        clr1_n = 0;
        #10;
        clr1_n = 1;
        #10;

        // 异步置位第二个触发器
        pr2_n = 0;
        #10;
        pr2_n = 1;
        #10;

        // 正常数据输入
        d1 = 1;
        d2 = 1;
        #20;

        $finish;
    end

endmodule    