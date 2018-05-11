`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:41:23 10/19/2015 
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
    input clk,
    input reset,
    input btn_east,
    input btn_west,
    output [7:0] led
    );
reg signed[3:0] num;
reg flag1, flag2;
reg [21:0] clk_counter; 
assign led[0] = num[0];
assign led[1] = num[1];
assign led[2] = num[2];
assign led[3] = num[3];
assign led[4] = num[3];
assign led[5] = num[3];
assign led[6] = num[3];
assign led[7] = num[3];
always @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		num <= 4'b0000;
		clk_counter <= 0;
		flag1 <= 0;
		flag2 <= 0;
	end
	else
	begin
		//sub
		if (btn_east)
		begin
			clk_counter <= (clk_counter == 21'b111111111111111111111) ? clk_counter : clk_counter + 1;
			if (clk_counter == 21'b111111111111111111111)
			begin
				if (num != -8 && flag1 !=1)
				begin
					num <= num - 1;
					flag1 <= 1;
				end
			end
		end	
		//add
		else if (btn_west)
		begin
			clk_counter <= (clk_counter == 21'b111111111111111111111) ? clk_counter : clk_counter + 1;
			if (clk_counter == 21'b111111111111111111111)
			begin
				if (num != 7 && flag2 !=1)
				begin
					num <= num + 1;
					flag2 <= 1;
				end
			end
		end
		else if (!btn_east || !btn_west)
		begin
			if (clk_counter == 21'b111111111111111111111)
			begin
				clk_counter <= 0;
				flag1 <= 0;
				flag2 <= 0;
			end
		end
	end
end
		
endmodule
