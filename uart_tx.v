module uart_tx(
    input clk2x,
    input clk1x,
    input mode,
    input en_start,
    input rst_n,
    input [7:0] Din,
    output TxD
);

    wire [3:0] count_out, count_out2;
    wire [1:0] state, next_state, neg_state, delay;
    wire reg_out, load, load_n, state10, neg_en_start;
    wire rco, count, neg_count_out0;
    wire term2, term3, term4, term5, term6, term7, term8;

    sn74ls166 register(
        .clk(count_out[0]),
        .clr_n(rst_n),
        .sh_ld_n(load_n), // 低电平时并行加载
        .ser(1'b1),     // 串行输入
        .clk_inh(1'b0), // 时钟禁止信号
        .p(Din),        // 并行数据输入
        .q(reg_out)       // 串行数据输出
    );

    assign next_state[0] = neg_state[1];
    sn74ls74 DFF1(
        .clk1(count_out[0]),
        .d1(next_state[1]),
        .clr1_n(1'b1),
        .pr1_n(rst_n),
        .q1(state[1]),
        .q1_n(neg_state[1]),

        .clk2(count_out[0]),
        .d2(next_state[0]),
        .clr2_n(rst_n),
        .pr2_n(1'b1),
        .q2(state[0]),
        .q2_n(neg_state[0])
    );
    sn74ls74 DFF2(
        .clk1(clk2x),
        .d1(rco),
        .clr1_n(rst_n),
        .pr1_n(1'b1),
        .q1(delay[0]),
        .q1_n(),
        
        .clk2(clk2x),
        .d2(delay[0]),
        .clr2_n(rst_n),
        .pr2_n(1'b1),
        .q2(delay[1]),
        .q2_n()
    );

    wire ld1;
    cd4073 AND1(
        .a1({state[0], state[1], 1'b1}),
        .a2({delay[1], state[0], state[1]}), // 0.5 delay
        .a3({count_out2[3], count_out2[2], count_out2[1]}), //count
        .y1({state10}),
        .y2(ld1),
        .y3(term2) 
    );
    
    cd4073 AND2(
        .a1({neg_state[1], state[0], count}), //FSM
        .a2({state10, mode, neg_en_start}), //FSM
        .a3({neg_en_start, neg_state[0], state[1]}), //FSM
        .y1(term3),
        .y2(term4),
        .y3(term5)
    );
    cd4073 AND3(
        .a1({neg_state[1], state[0], reg_out}), //output
        .a2({neg_state[1], neg_state[0], neg_count_out0}), // register load
        .y1(term8),
        .y2(load)
    );
    cd4073 AND4(
        .a1({term2, count_out2[0], neg_state[1]}), //count
        .a2({term7, state[0], 1'b1}), //count
        .y1(term7),
        .y2(count)
    );

    wire ld1_n;
    cd4069 NOT1(
        .in({en_start, ld1, load, count_out[0]}),
        .out({neg_en_start, ld1_n, load_n, neg_count_out0})
    );

    cd4071 OR1(
        .a1({state[1], term8}), //output
        .a2({term3, term4}), //FSM
        .a3({term5, term6}), //FSM
        .y1(TxD),
        .y2(term6),
        .y3(next_state[1])
    );
    
    sn74ls163a counter1(
        .clk(clk2x),
        .clr_n(rst_n),
        .ld_n(ld1_n), // 低电平有效
        .enp(1'b1),  // 计数使能 P
        .ent(1'b1),  // 计数使能 T
        .d(4'b0000), // 并行数据输入
        .q(count_out), // 计数器输入
        .rco()         // 进位输出
    );
    sn74ls163a counter2(
        .clk(clk2x),
        .clr_n(rst_n),
        .ld_n(load_n), // 低电平有效
        .enp(1'b1),  // 计数使能 P
        .ent(1'b1),  // 计数使能 T
        .d(4'b0000), // 并行数据输入
        .q(count_out2), // 计数器输入
        .rco(rco)         // 进位输出
    );
    
endmodule