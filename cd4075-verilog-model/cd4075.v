module cd4075 (
    input wire [2:0] a1,
    input wire [2:0] a2,
    input wire [2:0] a3,
    output wire y1,
    output wire y2,
    output wire y3
);

    // 实例化3个3输入或门
    assign y1 = a1[0] | a1[1] | a1[2];
    assign y2 = a2[0] | a2[1] | a2[2];
    assign y3 = a3[0] | a3[1] | a3[2];

endmodule    