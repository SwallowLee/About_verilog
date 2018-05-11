`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:51 11/23/2016 
// Design Name: 
// Module Name:    mux 
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
module mux( input [63:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31,
input rst,
input [5:0]select,
output [63:0] out
    );
	 
	reg [63:0]reg_out;
	assign out = reg_out;
	always @(select, rst, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31)
	begin
		if(rst)
			reg_out <= 64'd0;
		else
		case(select)
			6'd0: reg_out <= in0;
			6'd1: reg_out <= in1;
			6'd2: reg_out <= in2;
			6'd3: reg_out <= in3;
			6'd4: reg_out <= in4;
			6'd5: reg_out <= in5;
			6'd6: reg_out <= in6;
			6'd7: reg_out <= in7;
			6'd8: reg_out <= in8;
			6'd9: reg_out <= in9;
			6'd10: reg_out <= in10;
			6'd11: reg_out <= in11;
			6'd12: reg_out <= in12;
			6'd13: reg_out <= in13;
			6'd14: reg_out <= in14;
			6'd15: reg_out <= in15;
			6'd16: reg_out <= in16;
			6'd17: reg_out <= in17;
			6'd18: reg_out <= in18;
			6'd19: reg_out <= in19;
			6'd20: reg_out <= in20;
			6'd21: reg_out <= in21;
			6'd22: reg_out <= in22;
			6'd23: reg_out <= in23;
			6'd24: reg_out <= in24;
			6'd25: reg_out <= in25;
			6'd26: reg_out <= in26;
			6'd27: reg_out <= in27;
			6'd28: reg_out <= in28;
			6'd29: reg_out <= in29;
			6'd30: reg_out <= in30;
			6'd31: reg_out <= in31;
			default: reg_out <= 64'd0;
		endcase
	end


endmodule
