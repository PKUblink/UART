`timescale 1ns / 1ps

module tb_sn74ls163a;

    reg clk;
    reg clr_n;
    reg ld_n;
    reg enp;
    reg ent;
    reg [3:0] d;
    wire [3:0] q;
    wire rco;

    // 实例化被测试模块
    sn74ls163a uut (
       .clk(clk),
       .clr_n(clr_n),
       .ld_n(ld_n),
       .enp(enp),
       .ent(ent),
       .d(d),
       .q(q),
       .rco(rco)
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
        ld_n = 1;
        enp = 0;
        ent = 0;
        d = 4'b0000;
        #10;

        // 同步清零
        clr_n = 0;
        #10;
        clr_n = 1;
        #10;

        // 同步置数
        ld_n = 0;
        d = 4'b1010;
        #10;
        ld_n = 1;
        #10;

        // 计数
        enp = 1;
        ent = 1;
        #80;

        // 保持
        enp = 0;
        #20;

        $finish;
    end

endmodule    