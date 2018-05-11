`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:13:49 08/19/2015 
// Design Name: 
// Module Name:    adder_module 
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
module adder_tree(
    //input ports
    clk,
    rst,
    in_valid,
    in0,
    in1,
    in2,
    in3,
	 //output ports
    sum
    );
	 
	 input clk, rst;
	 input in_valid;
	 input[7:0] in0, in1, in2, in3;
	 output reg[31:0] sum;
	 
	 wire[8:0] adder1_1, adder1_2;
	 wire[10:0] adder2;
	 
	 assign adder1_1 = in_valid ? (in0 + in1) : 0;
	 assign adder1_2 = in_valid ? (in2 + in3) : 0;
	 
	 assign adder2 = adder1_1 + adder1_2;
	  
	 
    always @(posedge clk) begin
        if (rst) sum <= 0;
        else sum <= sum + adder2;
    end

endmodule
