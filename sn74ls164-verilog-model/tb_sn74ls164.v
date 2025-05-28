`timescale 1ns / 1ps

module tb_sn74ls164;

    reg clk;
    reg clr_n;
    reg a;
    reg b;
    wire [7:0] q;

    // 实例化被测试模块
    sn74ls164 uut (
       .clk(clk),
       .clr_n(clr_n),
       .a(a),
       .b(b),
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
        a = 0;
        b = 0;
        #10;

        // 异步清零
        clr_n = 0;
        #10;
        clr_n = 1;
        #10;

        // 串行输入数据
        a = 1; b = 1; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 0; b = 0; #10;
        a = 1; b = 1; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 0; b = 0; #10;

        $finish;
    end

endmodule    