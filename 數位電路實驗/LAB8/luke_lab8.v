`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:12 11/30/2015 
// Design Name: 
// Module Name:    luke_lab8 
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
module luke_lab8(
	 input clk,
	 input reset,
    input ROT_A,
    input ROT_B,
	 output led
    );
reg led_temp;
assign led = led_temp;
integer duty_cycle;
integer counter;	 
wire rotary_event,rotary_right;
Rotation_direction rd(
	.CLK(clk),
	.ROT_A(ROT_A),
	.ROT_B(ROT_B),
	.rotary_event(rotary_event),
	.rotary_right(rotary_right)
);

always @(posedge clk) begin
	if(reset)
		duty_cycle <=0;
	else if (rotary_event && rotary_right) begin
		if (duty_cycle<100)
			duty_cycle <= duty_cycle+1;
	end
	else if (rotary_event && !rotary_right) begin
		if (duty_cycle>0)
			duty_cycle <= duty_cycle-1;
	end
	else
		duty_cycle <= duty_cycle;
end

always @(posedge clk) begin
	if (reset)
		led_temp <= 1'b0;
	else if(counter < duty_cycle)
		led_temp <= 1'b1;
	else
		led_temp <= 1'b0;
end

always @(posedge clk) begin
	if (reset)
		counter <= 0;
	else if (counter < 100)
		counter <= counter+1;
	else if (counter == 100)
		counter <= 0;
	else
		counter <= counter;
end

endmodule

