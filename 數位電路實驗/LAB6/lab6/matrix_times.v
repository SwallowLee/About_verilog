`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:57 12/23/2016 
// Design Name: 
// Module Name:    matrix_times 
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
module matrix_times( input [7:0] v0, input [7:0] v1, input [7:0] v2, input [7:0] v3, input [7:0] num0, input [7:0] num1, input [7:0] num2, input [7:0] num3, input [3:0]con_valid, input clk, input reset, output [19:0] ans
    );

	wire [19:0] a0, a1, a2, a3;
	wire in_valid;
	
	assign in_valid = con_valid == 2? 1:0;
	
	times aa(.a(v0), .b(num0), .in_valid(con_valid), .ans(a0));
	times ab(.a(v1), .b(num1), .in_valid(con_valid), .ans(a1));
	times ac(.a(v2), .b(num2), .in_valid(con_valid), .ans(a2));
	times ad(.a(v3), .b(num3), .in_valid(con_valid), .ans(a3));
	
	adder_tree ae( .clk(clk), .rst(reset), .in_valid(in_valid), .in0(a0), .in1(a1), .in2(a2), .in3(a3), .sum(ans));

endmodule
