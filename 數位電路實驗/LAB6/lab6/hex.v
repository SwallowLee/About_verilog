`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:01:46 12/28/2016 
// Design Name: 
// Module Name:    hex 
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
module hex( input [7:0] num, input valid, output reg [7:0] hex
    );

	always @(posedge valid)
	begin
		case(num)
			8'd0: hex <= 8'd48;
			8'd1: hex <= 8'd49;
			8'd2: hex <= 8'd50;
			8'd3: hex <= 8'd51;
			8'd4: hex <= 8'd52;
			8'd5: hex <= 8'd53;
			8'd6: hex <= 8'd54;
			8'd7: hex <= 8'd55;
			8'd8: hex <= 8'd56;
			8'd9: hex <= 8'd57;
			8'd10: hex <= 8'd65;
			8'd11: hex <= 8'd66;
			8'd12: hex <= 8'd67;
			8'd13: hex <= 8'd68;
			8'd14: hex <= 8'd69;
			8'd15: hex <= 8'd70;
		endcase
	end

endmodule
