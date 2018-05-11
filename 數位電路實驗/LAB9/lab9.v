`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:47 11/22/2015 
// Design Name: 
// Module Name:    lcd 
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
module lab9(
    input clk,
    input reset,
    input  button,
    output LCD_E,
    output LCD_RS,
    output LCD_RW,
    output [3:0]LCD_D
    );

    wire btn_level, btn_pressed;
    reg prev_btn_level;
    reg [127:0] row_A, row_B;
	 reg [2:0] Q,Q_next;
	 reg [1:0] P,P_next;
	 reg [9:0] idx,jdx,counter;
	 reg reversed;
	 reg [31:0] acc;
	 reg [7:0] print_counter;
	 reg [9:0] print_addr;
	 parameter DELAY=350000000;
	 parameter S_INIT=3'b000,S_WAIT=3'b001,S_COUNT=3'b010,S_INCR=3'b011,S_OK=3'b100;
	 parameter T_INIT=2'b00,T_PRINT=2'b01,T_WAIT=2'b10,T_CLEAR=2'b11;
	 wire [7:0] w1,w2,w3,w4,w5;
	 
	 
	 //sram
	 reg  sram[1023:0];
	 reg  data_out;
	 reg  data_in;
	 wire  we, en;
	 wire [9:0] sram_addr;
	 assign sram_addr=(Q==S_INIT)?counter[9:0]:((P==T_INIT)?jdx[9:0]:print_addr[9:0]);	 
	 reg in_valid;
	 assign we = in_valid;     // Write data into SRAM when out_valid is high.
	 assign en = 1;
	 
	 assign w1=(print_counter[7:4]>9)?print_counter[7:4]+55:print_counter[7:4]+48;
	 assign w2=(print_counter[3:0]>9)?print_counter[3:0]+55:print_counter[3:0]+48;
	 assign w3=print_addr[9:8]+48;
	 assign w4=(print_addr[7:4]>9)?print_addr[7:4]+55:print_addr[7:4]+48;
	 assign w5=(print_addr[3:0]>9)?print_addr[3:0]+55:print_addr[3:0]+48;
	 
	 
	 LCD_module lcd0( 
      .clk(clk),
      .reset(reset),
      .row_A(row_A),
      .row_B(row_B),
      .LCD_E(LCD_E),
      .LCD_RS(LCD_RS),
      .LCD_RW(LCD_RW),
      .LCD_D(LCD_D)
    );
    
    debounce btn_db0(
      .clk(clk),
      .btn_input(button),
      .btn_output(btn_level)
   );
	
	always @(posedge clk) begin
      if (reset)
        prev_btn_level <= 1;
      else
        prev_btn_level <= btn_level;
    end

    assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;
	 
	 always @(posedge clk) begin // Write data into the SRAM block
      if (en && we) begin
        sram[sram_addr] <= data_in;
      end
    end
	 
	 always @(posedge clk) begin // The read data port of the SRAM is always active
      if (en && we)             // If data is being written into SRAM, also
        data_out <= data_in;    // forward the data to the read port
      else
        data_out <= sram[sram_addr];  // Send current data to the read port
    end
	 
	 always @(posedge clk)begin
	   if(reset)begin
	     Q<=S_INIT;
	     P<=T_INIT;
	   end
	   else begin
	     Q<=Q_next;
	     P<=P_next;
	   end
	 end
	 
	 always @(*)begin
	   case(Q)
	     S_INIT:
		    if(counter<1021)Q_next<=S_INIT;
		    else Q_next<=S_WAIT;
		  S_WAIT:
		    if(data_out)Q_next<=S_COUNT;
			 else Q_next<=S_INCR;
		  S_COUNT:
		    if(jdx<1024)Q_next<=S_COUNT;
		    else Q_next<=S_INCR;
		  S_INCR:
	       if(idx==1024)Q_next<=S_OK;
		    else Q_next<=S_WAIT;
		  S_OK:
		    if(reset)Q_next<=S_INIT;
			 else Q_next<=S_OK;
	    endcase
	  end
	  
		  
	 always @(posedge clk) begin
	   if(reset)begin
		  counter<=0;
	     in_valid<=1;
		end
		else if(Q==S_INIT)begin
		  idx<=2;
		  data_in<=1;
		  if(counter==1023)in_valid<=0;
		  else counter<=counter+1;
		end
		else if(Q==S_WAIT)begin
		  jdx<=2*idx;
		  if(data_out)in_valid<=1;
		end
		else if(Q==S_COUNT)begin
		  jdx<=jdx+idx;
		  data_in<=0;
		  if(jdx>=1024)in_valid<=0;
		end
		else if(Q==S_INCR)
		  idx<=idx+1;
	end
	
	always @(posedge clk) begin
		if(reset || P==T_CLEAR) 
			acc<=0;
		else if(Q==S_OK)
			acc<=acc+1;
	end
	always @(posedge clk) begin
		if(reset) 
			reversed <=0;
		else if(btn_pressed) 
			reversed <=1;
	end
	
	always @(*)begin
	  case(P)
	    T_INIT:
	      if(data_out)P_next=T_PRINT;
		   else P_next=T_INIT;
	    T_PRINT:
	      if(data_out)P_next=T_WAIT;
		   else P_next=T_PRINT;
	    T_WAIT:
		   if(acc<DELAY)P_next=T_WAIT;
		   else P_next=T_CLEAR;
	    T_CLEAR:
	      P_next=T_PRINT;
	    endcase
	end
	
	always @(posedge clk)begin
	  if(reset)begin
	    print_addr<=0;
		 print_counter<=1;
		 row_A<=128'h0;
		 row_B<=128'h0;
	  end
	  if(P==T_INIT)begin
	    row_A<=128'h0;
	    if(data_out)
			print_addr<=print_addr+1;
		 else begin
		   row_B <= {56'h5072696D652023,w1,w2,32'h20697320,w3,w4,w5};
			print_addr<=print_addr+1;
			print_counter<=print_counter+1;
		 end
	  end
	   if(P==T_PRINT)begin
	    if(data_out) begin
			if (reversed)
				print_addr <= print_addr-1;
			else
				print_addr <= print_addr+1;
		 end
		 else begin
		   row_A <= row_B;
		   row_B <= {56'h5072696D652023,w1,w2,32'h20697320,w3,w4,w5};
			if (reversed) begin
				print_addr <= print_addr-1;
				print_counter<=print_counter-1;
			end 
			else begin
				print_addr <= print_addr+1;
				print_counter<=print_counter+1;
			end
		 end
	  end
	end
	
    /*always @(posedge clk) begin
      if (reset) begin
        row_A <= 128'h22/48/65/6C/6C/6F/2C/20/57/6F/72/6C/64/21/22/20; // "Hello, World!"
        row_B <= 128'h44656D6F206F6620746865204C43442E; // Demo of the LCD.
      end
      else if (btn_pressed) begin
        row_A <= row_B;
        row_B <= row_A;
      end
    end*/

endmodule
