`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:09 11/23/2016 
// Design Name: 
// Module Name:    shift_unit 
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
module shift_unit( input[7:0] left, input[7:0] data, input clk, input rst, output reg [7:0] right
    );
	always @(posedge clk)
	begin
		if(rst)
		begin
			right <= data;
		end
		else
		begin
			right <= left;
		end
	end
	


endmodule
