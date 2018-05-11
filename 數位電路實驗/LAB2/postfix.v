`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:41 10/07/2015 
// Design Name: 
// Module Name:    postfix 
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
module postfix(
	input CLK, RESET, OP_MODE, IN_VALID, [3:0]IN,
	output reg [15:0]OUT, OUT_VALID
);
reg [15:0]sta[15:0];
reg [3:0]flag;
reg check;
always @(posedge CLK)
	if(!RESET)
	begin
		check <= 0;
		OUT <= 16'b0;
		OUT_VALID <= 0;
		flag <= 4'b0;
	end
	
	else 
	begin
		if(IN_VALID) 
		begin
			check <= 1;
			if(OP_MODE)
			begin
				if(IN == 4'b0001) sta[flag-2] = sta[flag-1] + sta[flag-2];
				else if(IN == 4'b0010) sta[flag-2] = sta[flag-2] - sta[flag-1];
				else if(IN == 4'b0100) sta[flag-2] = sta[flag-1] * sta[flag-2];
				flag <= flag-1;
			end
			
			else
			begin
				sta[flag] <= IN;
				flag = flag+1;
			end
		end
		
		else
		begin
			if(check)
			begin
				OUT_VALID <=1;
				OUT <= sta[0];
				check <=0;
			end
			
			else
			begin
				OUT <= 16'b0;
				OUT_VALID <= 0;
				flag <= 4'b0;
			end
		end
	end

endmodule
