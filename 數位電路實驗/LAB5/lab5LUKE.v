`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:16 10/20/2015 
// Design Name: 
// Module Name:    lab5 
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
module lab5(
    input clk,
    input reset,
    input button,
    input rx,
    output tx,
    output [7:0] led
    );

localparam [1:0] S_IDLE = 2'b00, S_WAIT = 2'b01, S_SEND = 2'b10, S_INCR = 2'b11;
localparam MEM_SIZE = 256;

// declare system variables
wire btn_pressed;
reg [7:0] send_counter;
reg [1:0] Q, Q_next;
reg [7:0] data[0:MEM_SIZE-1];
integer idx;
integer i;
integer j;
reg flag;
reg flag1;
// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;

assign led = { 7'b0, btn_pressed };
assign tx_byte = data[send_counter];

debounce btn_db(
    .clk(clk),
    .btn_input(button),
    .btn_output(btn_pressed)
    );

uart uart(
    .clk(clk),
    .rst(reset),
    .rx(rx),
    .tx(tx),
    .transmit(transmit),
    .tx_byte(tx_byte),
    .received(received),
    .rx_byte(rx_byte),
    .is_receiving(is_receiving),
    .is_transmitting(is_transmitting),
    .recv_error(recv_error)
    );

// Initializes the "Hello, World! " string
/*always begin
  data[ 0] = 8'h48;
  data[ 1] = 8'h65;
  data[ 2] = 8'h6C;
  data[ 3] = 8'h6C;
  data[ 4] = 8'h6F;
  data[ 5] = 8'h2C;
  data[ 6] = 8'h20;
  data[ 7] = 8'h57;
  data[ 8] = 8'h6F;
  data[ 9] = 8'h72;
  data[10] = 8'h6C;
  data[11] = 8'h64;
  data[12] = 8'h21;
  data[13] = 8'h20;
  data[14] = 8'h0;  // end of string
  for (idx = 15; idx < MEM_SIZE; idx = idx + 1) data[idx] = 8'h0;
end
*/
// ------------------------------------------------------------------------
// FSM of the "Hello, World!" transmission controller

always @(posedge clk) begin
  if (reset) begin
	Q <= S_IDLE;
	flag <= 0;
	flag1 <= 0;
  end
  else begin
	Q <= Q_next;
	flag <= btn_pressed;
	flag1 <= flag;
  end
end 

always @(*) begin // FSM next-state logic 
  case (Q)
    S_IDLE: // wait for button click
		if (flag == 1 && flag1 == 0) Q_next = S_WAIT;
		else Q_next = S_IDLE;
    S_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_SEND;
      else Q_next = S_WAIT;
    S_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_INCR; // transmit next character
      else Q_next = S_SEND;
    S_INCR:
      if (tx_byte == 8'h0) Q_next = S_IDLE; // string transmission ends
      else Q_next = S_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_WAIT)? 1 : 0;

// FSM-controlled send_counter incrementing data path
always @(posedge clk) begin
  if (reset || (Q == S_IDLE))
    send_counter <= 0;
  else if (Q == S_INCR)
    send_counter <= send_counter + 1;
end

// End of the FSM of the "Hello, World! " transmission controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The following logic stores the UART input in a temporary buffer
// You must replace this code by your own code to store multiple
// bytes of data.
//
wire [7:0] tolower;
assign tolower = rx_temp >= 97 && rx_temp <= 122 ? rx_temp - 32 : rx_temp;
always @(posedge clk) begin
  if (reset) begin
    rx_temp <= 8'b0;
	for (j=0;j<256;j=j+1)
	data[j] <=0;
	i <=0;
  end
  else if (received) begin 
    rx_temp <= rx_byte;
  end
  else if (tolower) begin
	data[i] <= tolower;
	rx_temp <= 0;
	i <= i+1;
  end
end
// ------------------------------------------------------------------------

endmodule
