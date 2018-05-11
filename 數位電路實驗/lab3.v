`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:20:26 11/04/2016 
// Design Name: 
// Module Name:    lab3 
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
module lab3(
	input clk,reset,btn_east,btn_west,
	output [7:0]led
    );
reg signed[3:0] counter;
wire east_hit,west_hit;
reg east_level,west_level,pre_east,pre_west;
reg [1023:0] east;
reg [1023:0] west;

assign led={counter[3],counter[3],counter[3],counter[3],counter};
assign east_hit= east_level==1 && pre_east==0 ? 1:0;
assign west_hit= west_level==1 && pre_west==0 ? 1:0;

always @(posedge clk)
begin
	if(reset==1)
	begin
			pre_east <= 0;
			pre_west <= 0;
	end
	else
	begin
		pre_east <= east_level;
		pre_west <= west_level; 
	end
end 

always @(posedge clk)
begin
	if(reset==1)
		counter <= 4'b0;
	else
		counter <= counter + (west_hit == 1 && counter < 7) - (east_hit == 1 && counter > -8);
end

always @(posedge clk)
begin
	if(reset==1)
	begin
		east_level <= 0;
		west_level <= 0;
		east <= 0;
		west <= 0;
	end
	else
	begin
		east_level <= (east != 0? 1:0);
		west_level <= (west != 0? 1:0);
		east <= { east[1022:0], btn_east };
		west <= { west[1022:0], btn_west };
	end
end
endmodule
