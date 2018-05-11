`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:18 12/23/2016 
// Design Name: 
// Module Name:    convert 
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
module convert(input [7:0]v0, v1, v2, 
input [3:0]con_valid, output [7:0]num
    );
	
	assign num = con_valid == 1? (v0 - 8'd48)*100 + (v1 - 8'd48)*10 + (v2 - 8'd48) : 0; 

endmodule
