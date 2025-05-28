`timescale 1ns / 1ps

module tb_cd4073;

    // 信号声明
    reg [2:0] a1;
    reg [2:0] a2;
    reg [2:0] a3;
    wire y1;
    wire y2;
    wire y3;

    // 实例化被测试模块
    cd4073 uut (
       .a1(a1),
       .a2(a2),
       .a3(a3),
       .y1(y1),
       .y2(y2),
       .y3(y3)
    );

    // 测试序列
    initial begin
        // 初始化输入
        a1 = 3'b000; a2 = 3'b000; a3 = 3'b000;
        #10;
        $display("Input: a1 = %b, a2 = %b, a3 = %b; Output: y1 = %b, y2 = %b, y3 = %b", a1, a2, a3, y1, y2, y3);

        a1 = 3'b001; a2 = 3'b010; a3 = 3'b100;
        #10;
        $display("Input: a1 = %b, a2 = %b, a3 = %b; Output: y1 = %b, y2 = %b, y3 = %b", a1, a2, a3, y1, y2, y3);

        a1 = 3'b111; a2 = 3'b111; a3 = 3'b111;
        #10;
        $display("Input: a1 = %b, a2 = %b, a3 = %b; Output: y1 = %b, y2 = %b, y3 = %b", a1, a2, a3, y1, y2, y3);

        $finish;
    end

endmodule    