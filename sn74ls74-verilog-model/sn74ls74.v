module sn74ls74 (
    input wire clk1,  // 第一个触发器的时钟信号
    input wire d1,    // 第一个触发器的数据输入
    input wire clr1_n, // 第一个触发器的异步复位信号，低电平有效
    input wire pr1_n,  // 第一个触发器的异步置位信号，低电平有效
    output reg q1,    // 第一个触发器的输出
    output reg q1_n,  // 第一个触发器的反相输出

    input wire clk2,  // 第二个触发器的时钟信号
    input wire d2,    // 第二个触发器的数据输入
    input wire clr2_n, // 第二个触发器的异步复位信号，低电平有效
    input wire pr2_n,  // 第二个触发器的异步置位信号，低电平有效
    output reg q2,    // 第二个触发器的输出
    output reg q2_n   // 第二个触发器的反相输出
);

    // 第一个D触发器
    always @(posedge clk1 or negedge clr1_n or negedge pr1_n) begin
        if (!clr1_n) begin
            q1 <= 1'b0;
            q1_n <= 1'b1;
        end else if (!pr1_n) begin
            q1 <= 1'b1;
            q1_n <= 1'b0;
        end else begin
            q1 <= d1;
            q1_n <= ~d1;
        end
    end

    // 第二个D触发器
    always @(posedge clk2 or negedge clr2_n or negedge pr2_n) begin
        if (!clr2_n) begin
            q2 <= 1'b0;
            q2_n <= 1'b1;
        end else if (!pr2_n) begin
            q2 <= 1'b1;
            q2_n <= 1'b0;
        end else begin
            q2 <= d2;
            q2_n <= ~d2;
        end
    end

endmodule    