`timescale 1ns / 1ps
`include "adder_tree.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:30:34 10/26/2015 
// Design Name: 
// Module Name:    SHIFT 
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
module SHIFT(input clk, input rst, output [7:0] led);
   reg [31:0] sum;
	wire [31:0] sum_wire;
   wire [7:0] in0, in1, in2, in3, in4, in5, in6, in7;
   reg [7:0] data0[0:31];
	reg [7:0] data1[0:31];
	reg [7:0] data2[0:31];
	reg [7:0] data3[0:31];
	reg [7:0] data4[0:31];
	reg [7:0] data5[0:31];
	reg [7:0] data6[0:31];
	reg [7:0] data7[0:31];
	reg [5:0] col;
   assign led = sum[15:8];
   wire data_available;
   reg data_available_reg;
	assign data_available = data_available_reg;
	//assign data_available_reg = 1;  //you must modify this in your code
	assign in0=data0[31];
	assign in1=data1[31];
	assign in2=data2[31];
	assign in3=data3[31];
	assign in4=data4[31];
	assign in5=data5[31];
	assign in6=data6[31];
	assign in7=data7[31];
   integer i;
	adder_tree add(
		.clk(clk),
		.rst(rst),
		.in_valid(data_available),
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.sum(sum_wire)
	);
always @(posedge clk)
begin
	sum <= sum_wire + 128;
    if (rst)
	begin
		`include "data.dat"
		col<=0;
		data_available_reg <=1;
    end
	else
	begin
		if(col<32)
			col <= col+1;
		if (col ==32)
			data_available_reg <=0;
		for(i=31;i>0;i=i-1)
		begin
			data0[i]<=data0[i-1];
			data1[i]<=data1[i-1];
			data2[i]<=data2[i-1];
			data3[i]<=data3[i-1];
			data4[i]<=data4[i-1];
			data5[i]<=data5[i-1];
			data6[i]<=data6[i-1];
			data7[i]<=data7[i-1];
		end
    end
end
endmodule
