`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:09:36 11/24/2016 
// Design Name: 
// Module Name:    shift_all 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module shift_all( input [7:0] sh0, sh1, sh2, sh3, sh4, sh5, sh6, sh7, sh8, sh9, sh10, sh11, sh12, sh13, sh14, sh15, sh16, sh17, sh18, sh19, sh20, sh21, sh22, sh23, sh24, sh25, sh26, sh27, sh28, sh29, sh30, sh31,
	input clk, input rst, output wire [7:0] in
    );
	
	wire [7:0] out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30;
	shift_unit a( 0, sh0, clk, rst, out0);
	shift_unit b(out0, sh1, clk, rst, out1);
	shift_unit c(out1, sh2, clk, rst, out2);
	shift_unit d(out2, sh3, clk, rst, out3);
	shift_unit e(out3, sh4, clk, rst, out4);
	shift_unit f(out4, sh5, clk, rst, out5);
	shift_unit g(out5, sh6, clk, rst, out6);
	shift_unit h(out6, sh7, clk, rst, out7);
	shift_unit i(out7, sh8, clk, rst, out8);
	shift_unit j(out8, sh9, clk, rst, out9);
	shift_unit k(out9, sh10, clk, rst, out10);
	shift_unit l(out10, sh11, clk, rst, out11);
	shift_unit m(out11, sh12, clk, rst, out12);
	shift_unit n(out12, sh13, clk, rst, out13);
	shift_unit o(out13, sh14, clk, rst, out14);
	shift_unit p(out14, sh15, clk, rst, out15);
	shift_unit q(out15, sh16, clk, rst, out16);
	shift_unit r(out16, sh17, clk, rst, out17);
	shift_unit s(out17, sh18, clk, rst, out18);
	shift_unit t(out18, sh19, clk, rst, out19);
	shift_unit u(out19, sh20, clk, rst, out20);
	shift_unit v(out20, sh21, clk, rst, out21);
	shift_unit w(out21, sh22, clk, rst, out22);
	shift_unit x(out22, sh23, clk, rst, out23);
	shift_unit y(out23, sh24, clk, rst, out24);
	shift_unit z(out24, sh25, clk, rst, out25);
	shift_unit aa(out25, sh26, clk, rst, out26);
	shift_unit bb(out26, sh27, clk, rst, out27);
	shift_unit cc(out27, sh28, clk, rst, out28);
	shift_unit dd(out28, sh29, clk, rst, out29);
	shift_unit ee(out29, sh30, clk, rst, out30);
	shift_unit ff(out30, sh31, clk, rst, in);


endmodule
