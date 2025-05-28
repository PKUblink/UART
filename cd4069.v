module cd4069 (
    input wire [5:0] in,
    output wire [5:0] out
);

    // 实例化6个反相器
    assign out[0] = ~in[0];
    assign out[1] = ~in[1];
    assign out[2] = ~in[2];
    assign out[3] = ~in[3];
    assign out[4] = ~in[4];
    assign out[5] = ~in[5];

endmodule    