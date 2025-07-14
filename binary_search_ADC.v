
// Code your design here
// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 01:44:18
// Design Name: 
// Module Name: ADC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2024 15:54:03
// Design Name: 
// Module Name: adc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_2x1(in,sel,out);
input [1:0]in; input sel;
output out;
wire t1,t2,t3;
not G1(t1,sel);
and G2(t2,in[0],t1);
and G3(t3,in[1],sel);
or G4(out,t3,t2);
endmodule


module mux_4x1(in,sel,out);
input [3:0]in;  input [1:0]sel;
output out;
wire [1:0]t;
mux_2x1 M0 (in[1:0],sel[0],t[0]);
mux_2x1 M1 (in[3:2],sel[0],t[1]);
mux_2x1 M2 (t,sel[1],out);
endmodule

module mux_8x1(in,sel,out);
input [7:0]in;
input [2:0]sel;
output out;
wire [1:0]t;
 mux_4x1 A0(in[3:0],sel[1:0],t[0]);
 mux_4x1 A1(in[7:4],sel[1:0],t[1]);
 mux_2x1 A2(t,sel[2],out);
 
 endmodule

module mux_16x1(in,sel,out);
input [15:0]in;
input [3:0]sel;
output out;
wire [3:0]t;
 mux_4x1 A0(in[3:0],sel[1:0],t[0]);
 mux_4x1 A1(in[7:4],sel[1:0],t[1]);
 mux_4x1 A2(in[11:8],sel[1:0],t[2]);
 mux_4x1 A3(in[15:12],sel[1:0],t[3]);
 mux_4x1 A5(t,sel[3:2],out);
endmodule

module mux_32x1(in,sel,out);
input [31:0]in;
input [4:0]sel;
output out;
wire [3:0]t;
 mux_16x1 B0(in[15:0],sel[3:0],t[0]);
 mux_16x1 B1(in[31:16],sel[3:0],t[1]);
 mux_2x1 B2(t, sel[4],out);
 endmodule
 
module mux_64x1(in,sel,out);
input [63:0]in;
input [5:0]sel;
output out;
wire [3:0]t;
 mux_32x1 C0(in[31:0],sel[4:0],t[0]);
 mux_32x1 C1(in[63:32],sel[4:0],t[1]);
 mux_2x1 C2(t, sel[5],out);
endmodule

module mux_128x1(in,sel,out);
input [127:0]in;
input [6:0]sel;
output out;
wire [3:0]t;
 mux_64x1 D0(in[63:0],sel[5:0],t[0]);
 mux_64x1 D1(in[127:64],sel[5:0],t[1]);
 mux_2x1 D2(t, sel[6],out);

endmodule
module comparator_2bit(A,B,H1,L1);
input A; input B;
output H1;
output L1;
wire t1,t2;
not G1(t2,A);
not G2( t1,B);
and G3(L1,A,t1);
and G4(H1,B,t2);
endmodule

module ADC(C,D,E,F,G,H,I,J,K,L,OUT1,OUT2);
input C, D; input [1:0]E; input [3:0]F; input [7:0]G; input [15:0]H; input [31:0]I; input [63:0]J; input [127:0]K;
output OUT1, OUT2; output[7:1]L;
wire [13:0]t;
wire [1:0] sel_4bit;
wire [2:0] sel_8x1;
wire [3:0] sel_16x1;
wire [4:0] sel_32x1;
wire [5:0] sel_64x1;
wire [6:0] sel_128x1;
assign sel_128x1={t[0],t[2],t[4],t[6],t[8],t[10],t[12]};
assign sel_64x1={t[0],t[2],t[4],t[6],t[8],t[10]};
assign sel_32x1={t[0],t[2],t[4],t[6],t[8]};
assign sel_16x1={t[0],t[2],t[4],t[6]};
assign sel_8x1={t[0],t[2],t[4]};
assign sel_4bit={t[0],t[2]};
comparator_2bit  X0(C,D,t[0],L[1]);
mux_2x1  X1 (E[1:0],t[0],t[1]);
comparator_2bit  X3(C,t[1],t[2],L[2]);
mux_4x1 X4 (F[3:0],sel_4bit,t[3]);
comparator_2bit  X5(C,t[3],t[4],L[3]);
mux_8x1 X6 (G[7:0],sel_8x1,t[5]);
comparator_2bit  X7(C,t[5],t[6],L[4]);
mux_16x1 X8(H[15:0],sel_16x1,t[7]);
comparator_2bit  X9(C,t[7],t[8],L[5]);
mux_32x1 X10(I[31:0],sel_32x1,t[9]);
comparator_2bit  X11(C,t[9],t[10],L[6]);
mux_64x1 X12(J[63:0],sel_64x1,t[11]);
comparator_2bit  X13(C,t[11],t[12],L[7]);
mux_128x1 X14(K[127:0],sel_128x1,t[13]);
comparator_2bit  X15(C,t[13], OUT1,OUT2);
endmodule
