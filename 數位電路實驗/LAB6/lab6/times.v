`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:51 12/23/2016 
// Design Name: 
// Module Name:    times 
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
module times( input [7:0] a, input [7:0] b, input [3:0]in_valid, output [19:0] ans
    );

	assign ans = in_valid == 2? a * b:0;

endmodule
