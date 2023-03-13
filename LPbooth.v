`timescale 1ns / 1ps

module booth5(a,b,y);
input [7:0]a,b;
output reg [15:0] y=0;
wire [3:0] copy, comp;
wire [8:0] d,i,s,k;
wire [11:0]p1,p2,p3;
wire [11:2]p4;
wire c0,cl,c2,c3;
wire [3:0] z;
wire [3:0]enable;

// pre encoder generating enable signal for traditional encoder
pre_encoder pe0(b[1],b[0],0,enable[0]);
pre_encoder pe1(b[1],b[0],0,enable[1]);
pre_encoder pe2(b[1],b[0],0,enable[2]);
pre_encoder pe3(b[1],b[0],0,enable[3]);

// BOOTH ENCODER
encoder e0(enable[0],b[1],b[0],0,copy[0],comp[0],z[0]);
encoder el (enable[1],b[3],b[2],b[1], copy[1],comp[1],z[1]);
encoder e2(enable[2],b[5],b[4],b[3], copy[2],comp[2],z[2]);
encoder e3(enable[3],b[7],b[6],b[5], copy[3],comp[3],z[3]);

//FIRST LINE DECODERS

dcoder d0(a[0],0,copy[0],comp[0],z[0],d[0]);
dcoder d1(a[1],a[0],copy[0],comp[0],z[0],d[1]);
dcoder d2(a[2],a[1],copy[0],comp[0],z[0],d[2]);
dcoder d3(a[3],a[2],copy[0],comp[0],z[0],d[3]);
dcoder d4(a[4],a[3],copy[0],comp[0],z[0],d[4]);
dcoder d5(a[5],a[4],copy[0],comp[0],z[0],d[5]);
dcoder d6(a[6],a[5],copy[0],comp[0],z[0],d[6]);
dcoder d7(a[7],a[6],copy[0],comp[0],z[0],d[7]);
dcoder d8(a[7],a[7],copy[0],comp[0],z[0],d[8]);

//SECOND LINE DECODERS

dcoder i0(a[0],0,copy[1],comp[1],z[1],i[0]);
dcoder il(a[1],a[0],copy[1],comp[1],z[1],i[1]);
dcoder i2(a[2],a[1],copy[1],comp[1],z[1],i[2]);
dcoder i3(a[3],a[2],copy[1],comp[1],z[1],i[3]);
dcoder i4(a[4],a[3],copy[1],comp[1],z[1],i[4]);
dcoder i5(a[5],a[4],copy[1],comp[1],z[1],i[5]);
dcoder i6(a[6],a[5],copy[1],comp[1],z[1],i[6]);
dcoder i7(a[7],a[6],copy[1],comp[1],z[1],i[7]);
dcoder i8(a[7],a[7],copy[1],comp[1],z[1],i[8]);

//THIRD LINE DECODERS
dcoder s0(a[0],0,copy[2],comp[2],z[2],s[0]);
dcoder sl(a[1],a[0],copy[2],comp[2],z[2],s[1]);
dcoder s2(a[2],a[1],copy[2],comp[2],z[2],s[2]);
dcoder s3(a[3],a[2],copy[2],comp[2],z[2],s[3]);
dcoder s4(a[4],a[3],copy[2],comp[2],z[2],s[4]);
dcoder s5(a[5],a[4],copy[2],comp[2],z[2],s[5]);
dcoder s6(a[6],a[5],copy[2],comp[2],z[2],s[6]);
dcoder s7(a[7],a[6],copy[2],comp[2],z[2],s[7]);
dcoder s8(a[7],a[7], copy[2],comp[2],z[2],s[8]);

//FOURTH LINE DECODERS

dcoder k0(a[0],0,copy[3],comp[3],z[3],k[0]);
dcoder k1(a[1],a[0], copy[3],comp[3],z[3],k[1]);
dcoder k2(a[2],a[1], copy[3],comp[3],z[3],k[2]);
dcoder k3(a[3],a[2],copy[3],comp[3],z[3],k[3]);
dcoder k4(a[4],a[3],copy[3],comp[3],z[3],k[4]);
dcoder k5(a[5],a[4],copy[3],comp[3],z[3],k[5]);
dcoder k6(a[6],a[5],copy[3],comp[3],z[3],k[6]);
dcoder k7(a[7],a[6], copy[3],comp[3],z[3],k[7]);
dcoder k8(a[7],a[7], copy[3],comp[3],z[3],k[8]);

//1ST STAGE ADDERS

Radder r01(d[0],d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[8],~d[8],0,0,0,i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],~i[8],1,comp[0],p1,c0);
Radder r02(p1[2],p1[3],p1[4],p1[5],p1[6],p1[7],p1[8],p1[9],p1[10],p1[11],c0,0,0,0,s[0],s[1],s[2],s[3],s[4],s[5],s[6],s[7],~s[8],1,comp[1],p2,c1);
Radder r03(p2[2],p2[3],p2[4],p2[5],p2[6],p2[7],p2[8],p2[9],p2[10],p2[11],c1,0,0,0,k[0], k[1],k[2], k[3],k[4],k[5],k[6],k[7],~k[8],1,comp[2],p3,c2);
Radder_10bit r04(p3[2],p3[3],p3[4],p3[5],p3[6],p3[7],p3[8],p3[9],p3[10],p3[11], comp[3],p4,c3);

always @(*)
y={p4,p3[1],p3[0],p2[1],p2[0],p1[1],p1[0]};

endmodule


//verilog code for pre encoder
module pre_encoder(b2,b1,b0,z);
input b2,b1,b0;
output z;
nor(z,(b2&b1&b0),(~b2&~b1&~b0));
endmodule


//VERILOG CODE FOR BOOTH ENCODER
module encoder (enable,b2,b1,b0, copy, comp, z);
input enable,b2,b1,b0;
output copy, comp, z;

if (!enable==1)begin

wire y0,yl,y2,y3,y4,y5,y6,y7;

DEC3to8 d01(b2,b1,b0, y0, yl, y2, y3, y4, y5, y6, y7);
assign z=y0|y7;
assign comp=y4|y5|y6;
assign copy=yl|y2|y5|y6;
end
else begin 
assign {p3,p2,p1}=0;
end
endmodule

//VERILOG CODE FOR BOOTH DECODER
module dcoder (al,a0, copy, comp, z,k);
input al,a0,copy,comp, z;
output reg k;
always @(*)
begin
case ({z, copy, comp})
3'd0: k<=a0;
3'd1: k<=~a0;
3'd2: k<=al;
3'd3: k<=-al;
3'd4: k<=0;
3'd5: k<=0;
3'd6: k<=0;
3'd7: k<=0;
endcase
end
endmodule

//VERILOG CODE FOR RIPPLE ADDER 

module Radder(a0,al,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,c, sum, cout);
input a0,al,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,c;
output [11:0] sum;
output cout;
wire [10:0]w;
FAdder f0(a0,b0,c,sum[0],w[0]);
FAdder fl(al,b1,w[0],sum[1],w[1]);
FAdder f2 (a2,b2,w[1],sum[2],w[2]);
FAdder f3(a3,b3,w[2],sum[3],w[3]);
FAdder f4(a4,b4,w[3],sum[4],w[4]);
FAdder f5(a5,b5,w[4],sum[5],w[5]);
FAdder f6(a6,b6,w[5],sum[6],w[6]);
FAdder f7(a7,b7,w[6],sum[7],w[7]);
FAdder f8 (a8,b8,w[7],sum[8],w[8]);
FAdder f9(a9,b9,w[8],sum[9],w[9]);
FAdder f10(a10,b10,w[9],sum[10],w[10]);
FAdder f11(a11,b11,w[10],sum[11], cout);
endmodule

//VERILOG CODE FOR 10-BIT RIPPLE ADDER USED IN LAST STAGE OF ADDITION
module Radder_10bit (p2,p3,p4,p5, p6, p7, p8, p9, p10, p11, comp2, s4, c3);
input p2,p3,p4,p5,p6,p7,p8,p9, p10, p11, comp2;
output c3;
output [11:2]s4;
wire [10:2] w;
HA h2(p2,comp2,s4[2],w[2]);
HA h3(p3,w[2],s4[3],w[3]);
HA h4(p4,w[3],s4[4],w[4]);
HA h5(pS,w[4],s4[5],w[5]);
HA h6(p6,w[5],s4[6],w[6]);
HA h7(p7,w[6],s4[7],w[7]);
HA h8(p8,w[7],s4[8],w[8]);
HA h9(p9,w[8],s4[9],w[9]);
HA h10(p10,w[9],s4[10],w[10]);
HA h1l(p11,w[10],s4[11],c3);
endmodule

module HA(a,b, sum, carry);
input a,b;
output reg sum;
output carry;
and (carry,a,b);
always @(*)
begin
case ({a,b})
2'd0:begin sum= 0; end
2'd1:begin sum= 1; end
2'd2:begin sum= 1; end
2'd3:begin sum= 0; end
endcase
end
endmodule

//VERILOG CODE FOR FULL ADDER

module FAdder(A,B,Cin,S,Co);
input A,B,Cin;
output S,Co;
wire y0,yl, y2,y3,y4,y5,y6,y7;
DEC3to8 ins(A,B,Cin,y0,yl,y2,y3,y4,y5,y6,y7);
or o1(S,yl ,y2 ,y4, y7);
or o2(Co,y3,y5,y6,y7);
endmodule

//Definition of Decoder.
module DEC3to8 (X2,X1,X0,y0,y1,y2,y3,y4,y5,y6,y7);
input X1,X2,X0;
output reg y0,y1,y2,y3,y4,y5, y6, y7;
always@ (X0,X1,X2)
begin
case ( {X2,X1,X0}) 
3'b000: begin y0 = 1; y1=0 ;y2 = 0; y3=0 ;y4 = 0; y5=0 ;y6 = 0; y7=0; end 
3'b001: begin y0 =0;y1=1 ;y2 = 0; y3=0 ;y4 = 0; y5=0 ;y6 = 0; y7=0 ; end
3'b010: begin y0 = 0; y1=0 ;y2 = 1; y3=0 ;y4 = 0; y5=0 ;y6 = 0; y7=0 ; end
3'b011:begin y0 = 0; y1=0 ;y2 = 0; y3=1 ;y4 = 0; y5=0 ;y6 = 0; y7=0 ;end 
3'b100:begin y0 = 0; y1=0 ;y2 = 0; y3=0 ;y4 = 1; y5=0 ;y6 = 0; y7=0 ;end 
3'b101:begin y0 = 0; y1=0 ;y2 = 0; y3=0 ;y4 = 0; y5=1 ;y6 = 0; y7=0 ;end 
3'b110:begin y0 = 0; y1=0 ;y2 = 0; y3=0 ;y4 = 0; y5=0 ;y6 = 1; y7=0 ;end
3'b111:begin y0 = 0; y1=0 ;y2 = 0; y3=0 ;y4 = 0; y5=0 ;y6 = 0; y7=1 ;end 
endcase
end
endmodule