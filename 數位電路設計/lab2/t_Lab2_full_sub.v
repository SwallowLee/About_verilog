module t_Lab2_full_sub;
	wire D,B;
	reg x,y,z;
	Lab2_full_sub M1(D,B,x,y,z);
	initial begin
		x=1'b0;y=1'b0;z=1'b0;
	    #20	x=1'b0;y=1'b0;z=1'b1;
	    #20 x=1'b0;y=1'b1;z=1'b0;
	    #20 x=1'b0;y=1'b1;z=1'b1;
	    #20 x=1'b1;y=1'b0;z=1'b0;
	    #20	x=1'b1;y=1'b0;z=1'b1;
	    #20 x=1'b1;y=1'b1;z=1'b0;
	    #20 x=1'b1;y=1'b1;z=1'b1;
	end
	initial #200 $finish;
endmodule