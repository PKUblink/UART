`timescale 1ns / 1ps

module tb_uart_tx;

    // 定义信号
    reg clk2x;
    reg clk1x;
    reg mode;
    reg en_start;
    reg rst_n;
    reg [6:0] Din;
    wire TxD;

    // 实例化被测试模块
    uart_tx uut (
       .clk2x(clk2x),
       .clk1x(clk1x),
       .mode(mode),
       .en_start(en_start),
       .rst_n(rst_n),
       .Din(Din),
       .TxD(TxD)
    );

    // 生成时钟信号
    initial begin
        clk2x = 0;
        forever #26041.67 clk2x = ~clk2x; // 19200Hz 时钟周期约为 52083.33ns
    end

    initial begin
        clk1x = 0;
        forever #52083.33 clk1x = ~clk1x; // 9600Hz 时钟周期约为 104166.67ns
    end

    // 测试序列
    initial begin
        // 初始化信�?
        mode = 1;
        en_start = 0;
        rst_n = 0;
        Din = 7'b0000000;
        #200;

        // 释放复位信号
        rst_n = 1;
        #200;

        // 单次发�?�模式测�?
        mode = 1;
        Din = 7'b1010101;
        en_start = 1;
        #500000000; // 模拟按键按下 500ms
        en_start = 0;
        #1000000000; // 等待发�?�完�?

        // 连续发�?�模式测�?
        mode = 0;
        Din = 7'b0101010;
        #2000000000; // 持续发�?�一段时�?

        $finish;
    end

endmodule    