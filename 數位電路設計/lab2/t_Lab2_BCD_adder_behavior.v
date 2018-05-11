module t_Lab2_BCD_adder_behavior;
	wire[3:0] D;
	wire B;
	reg[3:0] x,y;
	reg z;
	Lab2_BCD_adder_behavior M1(D,B,x,y,z);
	initial begin
		x=4'b0100;y=4'b0010;z=1'b0;
	    #20	x=4'b0100;y=4'b0010;z=1'b1;
	    #20 x=4'b0101;y=4'b0110;z=1'b0;
	    #20 x=4'b0101;y=4'b0110;z=1'b1;
	    #20 x=4'b1001;y=4'b0111;z=1'b0;
	    #20	x=4'b1001;y=4'b0111;z=1'b1;
	end
	initial #200 $finish;
endmodule