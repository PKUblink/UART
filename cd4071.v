module cd4071 (
    input wire [1:0] a1,
    input wire [1:0] a2,
    input wire [1:0] a3,
    input wire [1:0] a4,
    output wire y1,
    output wire y2,
    output wire y3,
    output wire y4
);

    // 实例化4个2输入或门
    assign y1 = a1[0] | a1[1];
    assign y2 = a2[0] | a2[1];
    assign y3 = a3[0] | a3[1];
    assign y4 = a4[0] | a4[1];

endmodule    