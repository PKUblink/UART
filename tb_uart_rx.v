`timescale 1ns / 1ps

module tb_uart_rx;

    // 信号声明
    reg RxD;
    reg clk8x;
    reg rst_n;
    wire [6:0] Dout;

    // 实例化被测试模块
    uart_rx uut (
       .RxD(RxD),
       .clk8x(clk8x),
       .rst_n(rst_n),
       .Dout(Dout)
    );

    // 生成 8 倍时钟信号（9600×8Hz）
    initial begin
        clk8x = 0;
        forever #6510.42 clk8x = ~clk8x; // 9600×8Hz 时钟周期约为 13020.83ns
    end

    // 测试序列
    initial begin
        // 初始化信号
        RxD = 1;
        rst_n = 0;
        #200;

        // 释放复位信号
        rst_n = 1;
        #200;

        // 模拟发送一帧数据
        send_frame(7'b1010101);

        #100000; // 等待一段时间，确保接收完成

        $finish;
    end

    // 定义发送一帧数据的任务
    task send_frame;
        input [6:0] data;
        integer i;
        begin
            // 起始位
            RxD = 0;
            #104166.67; // 9600Hz 时钟周期，约 104166.67ns

            // 数据位（LSB 优先）
            for (i = 0; i < 7; i = i + 1) begin
                RxD = data[i];
                #104166.67;
            end

            // 停止位
            RxD = 1;
            #104166.67;
        end
    endtask

endmodule    