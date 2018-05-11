`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:10 10/10/2015 
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

  reg [5:0] counter;
  reg btn_east_clicked;
  reg btn_west_clicked;
  reg [15:0] east_avg;
  reg [15:0] west_avg;

  assign led = { counter[5], counter[5], counter };

  always @(posedge reset, posedge btn_east_clicked, posedge btn_west_clicked)
    if (reset == 1)
      counter = 6'b000000;
    else begin
      if (btn_east_clicked == 1)
          counter = counter - 1;
      else if (btn_west_clicked == 1)
          counter = counter + 1;
      else
          counter = counter;
    end

  always @(posedge clk, posedge reset)
    if (reset == 1)
      btn_east_clicked <= 0;
    else
      btn_east_clicked <= (east_avg != 0)? 1 : 0;

  always @(posedge clk, posedge reset)
    if (reset == 1)
      btn_west_clicked <= 0;
    else
      btn_west_clicked <= (west_avg != 0)? 1 : 0;

  always @(posedge clk, posedge reset)
    if (reset == 1)
      east_avg <= 0;
    else
      east_avg <= { east_avg[14:0], btn_east };

  always @(posedge clk, posedge reset)
    if (reset == 1)
      west_avg <= 0;
    else
      west_avg <= { west_avg[14:0], btn_west };

endmodule
