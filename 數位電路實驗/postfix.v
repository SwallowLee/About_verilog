`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:01 10/28/2016 
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
   input CLK,RESET,IN_VALID,OP_MODE,[3:0]IN,
	output reg OUT_VALID,reg [15:0]OUT
    );
	reg [15:0]stack[15:0];
	reg [3:0]top;
	reg check_invalid;
		always @(posedge RESET)
		begin
			top<=4'b0;
			OUT<=16'b0;
			check_invalid<=0;
		end
		always @(posedge CLK)
		begin
			if(RESET)
			begin
				if(IN_VALID)
				begin
					check_invalid<=1;
					if(!OP_MODE)
					begin	
						stack[top]<=IN;
						top=top+1;
					end
					else
					begin
						if(IN==4'b0001) stack[top-2]<=stack[top-1]+stack[top-2];
						else if(IN==4'b0010) stack[top-2]<=stack[top-2]-stack[top-1];
						else if(IN==4'b0100) stack[top-2]<=stack[top-1]*stack[top-2];
						top<=top-1;
					end
				end
				else
				begin
					if(check_invalid)
					begin
						check_invalid<=0;
						OUT_VALID<=1;
						OUT<=stack[0];
					end
					else
					begin
						OUT_VALID<=0;
						OUT<=16'b0;
						top<=4'b0;
					end
				end
			end
		end
endmodule

