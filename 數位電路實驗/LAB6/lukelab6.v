`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:09 11/16/2015 
// Design Name: 
// Module Name:    lukelab6 
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
module lukelab6(
input clk,
    input reset,
    input button,
    input rx,
    output tx,
    output [7:0] led
    );

localparam [2:0] S_IDLE = 3'b000, S_WAIT = 3'b001, S_SEND = 3'b010, S_INCR = 3'b011, S_BLOCK = 3'b100;
localparam MEM_SIZE = 96;


// declare system variables
wire btn_pressed;
reg [7:0] send_counter;
reg [1:0] Q, Q_next;
reg [7:0] data[0:MEM_SIZE-1];
wire [7:0] da[0:MEM_SIZE-1];

// declare new variables
reg [7:0] matrix[0:15];
reg [7:0] matrix_2[0:31];
reg [19:0] temp[0:127];
reg [19:0] sum[0:15];
integer idx;

debounce btn_db(
    .clk(clk),
    .btn_input(button),
    .btn_output(btn_pressed)
    );
// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error; 
reg  [5:0] index;
reg flag1,flag2;
reg [21:0] clk_counter;
reg test;
assign led =  {test,temp[0][6:0]} ;
assign tx_byte = data[send_counter];

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
always @(posedge clk) begin
  if (reset) Q <= S_IDLE;
  else
  begin  
	flag1<=btn_pressed;
	flag2<=flag1;
	Q <= Q_next;
  end
end

reg  [4:0]k;
always @(*) begin // FSM next-state logic
	 case (Q)
	 S_IDLE: // wait for button click
		if (!flag2&&flag1&&k>=4) Q_next = S_WAIT;
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

// ------------------------------------------------------------------------
// The following logic stores the UART input in a temporary buffer
// You must replace this code by your own code to store multiple
// bytes of data.
//
always @(posedge clk) begin
	if (reset)
	begin
		index <= 0;
	end
	else if (received)
	begin
		if(index < 16) //insert matrix_1
		begin
			matrix[index]<=rx_byte;
			index<=index+1;
		end
		else if (index > 15 && index <32)
		begin
			matrix_2[index]<=rx_byte;
			index<=index+1;
		end
	end	
	/*
	else if(index==32) begin	
		temp[k*16] <= matrix[0]*matrix_2[k+16];
		temp[k*16+1] <= matrix[1]*matrix_2[k+20];
		temp[k*16+2] <= matrix[2]*matrix_2[k+24];
		temp[k*16+3] <= matrix[3]*matrix_2[k+28];
		
		temp[k*16+4] <= matrix[4]*matrix_2[k+16];
		temp[k*16+5] <= matrix[5]*matrix_2[k+20];
		temp[k*16+6] <= matrix[6]*matrix_2[k+24];
		temp[k*16+7] <= matrix[7]*matrix_2[k+28];
		
		temp[k*16+8] <= matrix[8]*matrix_2[k+16];
		temp[k*16+9] <= matrix[9]*matrix_2[k+20];
		temp[k*16+10] <= matrix[10]*matrix_2[k+24];
		temp[k*16+11] <= matrix[11]*matrix_2[k+28];
		
		temp[k*16+12] <= matrix[12]*matrix_2[k+16];
		temp[k*16+13] <= matrix[13]*matrix_2[k+20];
		temp[k*16+14] <= matrix[14]*matrix_2[k+24];
		temp[k*16+15] <= matrix[15]*matrix_2[k+28];
		if(k==0) begin
			sum[0] <= temp[0]+temp[1]+temp[2]+temp[3];			
			sum[4] <= temp[4]+temp[5]+temp[6]+temp[7];
			sum[8] <= temp[8]+temp[9]+temp[10]+temp[11];
			sum[12] <= temp[12]+temp[13]+temp[14]+temp[15];
		end
		else if(k==1) begin
			sum[1] <= temp[16]+temp[17]+temp[18]+temp[19];
			sum[5] <= temp[20]+temp[21]+temp[22]+temp[23];
			sum[9] <= temp[24]+temp[25]+temp[26]+temp[27];
			sum[13] <= temp[28]+temp[29]+temp[30]+temp[31];
		end
		else if(k==2) begin
			sum[2] <= temp[32]+temp[33]+temp[34]+temp[35];
			sum[6] <= temp[36]+temp[37]+temp[38]+temp[39];
			sum[10] <= temp[40]+temp[41]+temp[42]+temp[43];
			sum[14] <= temp[44]+temp[45]+temp[46]+temp[47];
		end
		else if(k==3) begin
			test <=1;
			sum[3] <= temp[48]+temp[49]+temp[50]+temp[51];
			sum[7] <= temp[52]+temp[53]+temp[54]+temp[55];
			sum[11] <= temp[56]+temp[57]+temp[58]+temp[59];
			sum[15] <= temp[60]+temp[61]+temp[62]+temp[63];
		end
		k <= k+1;
	end
	*/
end

always @ (posedge clk )
begin 
	if(reset)begin 
		k <= 0 ; 
	end 
	else begin 
		if(index == 32 )begin 
			k <= k +4 ;
			sum[k] <= matrix[k]*matrix_2[16]+matrix[k+1]*matrix_2[20]+matrix[k+2]*matrix_2[24]+matrix[k+3]*matrix_2[28];			
			sum[k+1] <= matrix[k]*matrix_2[17]+matrix[k+1]*matrix_2[21]+matrix[k+2]*matrix_2[25]+matrix[k+3]*matrix_2[29];
			sum[k+2] <= matrix[k]*matrix_2[18]+matrix[k+1]*matrix_2[22]+matrix[k+2]*matrix_2[26]+matrix[k+3]*matrix_2[30]; 
			sum[k+3] <= matrix[k]*matrix_2[19]+matrix[k+1]*matrix_2[23]+matrix[k+2]*matrix_2[27]+matrix[k+3]*matrix_2[31];			
		end 	
	end 
end 



ascii a(.a(sum[0]),.b(da[4]),.c(da[3]),.d(da[2]),.e(da[1]),.f(da[0]));
ascii b(.a(sum[1]),.b(da[10]),.c(da[9]),.d(da[8]),.e(da[7]),.f(da[6]));
ascii c(.a(sum[2]),.b(da[16]),.c(da[15]),.d(da[14]),.e(da[13]),.f(da[12]));
ascii d(.a(sum[3]),.b(da[22]),.c(da[21]),.d(da[20]),.e(da[19]),.f(da[18]));
ascii e(.a(sum[4]),.b(da[28]),.c(da[27]),.d(da[26]),.e(da[25]),.f(da[24]));
ascii f(.a(sum[5]),.b(da[34]),.c(da[33]),.d(da[32]),.e(da[31]),.f(da[30]));
ascii g(.a(sum[6]),.b(da[40]),.c(da[39]),.d(da[38]),.e(da[37]),.f(da[36]));
ascii h(.a(sum[7]),.b(da[46]),.c(da[45]),.d(da[44]),.e(da[43]),.f(da[42]));
ascii ii(.a(sum[8]),.b(da[52]),.c(da[51]),.d(da[50]),.e(da[49]),.f(da[48]));
ascii j(.a(sum[9]),.b(da[58]),.c(da[57]),.d(da[56]),.e(da[55]),.f(da[54]));
ascii kk(.a(sum[10]),.b(da[64]),.c(da[63]),.d(da[62]),.e(da[61]),.f(da[60]));
ascii l(.a(sum[11]),.b(da[70]),.c(da[69]),.d(da[68]),.e(da[67]),.f(da[66]));
ascii m(.a(sum[12]),.b(da[76]),.c(da[75]),.d(da[74]),.e(da[73]),.f(da[72]));
ascii n(.a(sum[13]),.b(da[82]),.c(da[81]),.d(da[80]),.e(da[79]),.f(da[78]));
ascii o(.a(sum[14]),.b(da[88]),.c(da[87]),.d(da[86]),.e(da[85]),.f(da[84]));
ascii p(.a(sum[15]),.b(da[94]),.c(da[93]),.d(da[92]),.e(da[91]),.f(da[90]));

integer i;
always
begin
	for(i = 0; i < 96;i = i+1)
	begin
		if(i==5||i==11||i==17||i==29||i==35||i==41||i==53||i==59||i==65||i==77||i==83||i==89)  data[i]=32;
		else if(i==23||i==47||i==71)data[i]=13;
		else	data[i]=da[i];
	end
end
endmodule 

module ascii(input [19:0]a,output [7:0]b,output [7:0]c,output [7:0]d,output [7:0]e,output [7:0]f);
	assign b = (a[3:0]<=9)? (a[3:0]+48):(a[3:0]+55);
	assign c = (a[7:4]<=9)? (a[7:4]+48):(a[7:4]+55);
	assign d = (a[11:8]<=9)? (a[11:8]+48):(a[11:8]+55);
	assign e = (a[15:12]<=9)? (a[15:12]+48):(a[15:12]+55);
	assign f = (a[19:16]<=9)? (a[19:16]+48):(a[19:16]+55);
endmodule
