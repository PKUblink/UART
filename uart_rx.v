`timescale 1ns/1ps
module UART(
    input wire clk8x,      // ʱ���ź�
    input wire rst_n,    // ��λ�źţ��͵�ƽ��Ч
    input wire  pr_n,   //�첽��λ
    input wire RxD,     // ������������
    output wire [7:0] Dout // �����������
    );
//by Peking University Fanjie Kong

wire[31:0] wires;
wire wires4;
wire wires9;
wire[18:0] hang;


cd4069 cd4069_inst (
    .in({RxD,wires[4],wires[9],1'b1,1'b1,1'b1}),//��1
    .out({wires[1],wires[18],wires[17],hang[12],hang[11],hang[10]})
);  //������


cd4073 cd4073_inst (
    .a1({rst_n,wires[17],1'b1}),//3and1
    .a2({rst_n,wires[18],wires[17]}),
    .a3({wires[12],wires[13],wires[14]}),
    .y1(wires[15]),
    .y2(wires[19]),
    .y3(wires[4])
); //����������



wire cd4075out[2:0];
cd4075 cd4075_inst (
    .a1({wires[3],wires[10],wires[11]}),//3or1
    .a2({wires[12],wires[13],wires[14]}),//3or2
    .a3({wires[6],wires[7],wires[8]}),//3or3
    .y1(wires[16]),
    .y2(wires[11]),
    .y3(wires[10])
);//���������




sn74ls164 sn74ls164_inst (
    .clk(wires[4]),
    .clr_n(rst_n),
    .a(RxD),
    .b(1'b1),
    .q(Dout)
); //8λ�������벢�������λ�Ĵ���

wire sn74ls163aout[3:0];
sn74ls163a counter1 (
    .clk(clk8x),
    .clr_n(wires[1]),
    .ld_n(wires[17]),
    .enp(1'b1),
    .ent(wires[1]),
    .d({1'b0,1'b0,1'b0,1'b0}),
    .q({hang[0],wires[3],hang[1],hang[2]}),
    .rco()
); //4λ�����Ƽ�����

sn74ls163a counter2 (
    .clk(clk8x),
    .clr_n(wires[19]),
    .ld_n(1'b1),
    .enp(1'b1),
    .ent(wires[16]),
    .d(),
    .q({hang[16],wires[12],wires[13],wires[14]}),
    .rco()
); //4λ�����Ƽ�����

sn74ls163a counter3 (
    .clk(clk8x),
    .clr_n(wires[15]),
    .ld_n(1'b1),
    .enp(1'b1),
    .ent(wires[4]),
    .d(),
    .q({wires[9],wires[8],wires[7],wires[6]}),
    .rco()
); //4λ�����Ƽ�����
endmodule
