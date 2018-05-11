module t_Lab2_half_sub;
	wire D_gate,B_gate;
	wire D_data,B_data;
	wire D_behavior,B_behavior;
	reg x,y;
	Lab2_half_sub_gatelevel M1(D_gate,B_gate,x,y);
	Lab2_half_sub_dataflow M2(D_data,B_data,x,y);
	Lab2_half_sub_behavior M3(D_behavior,B_behavior,x,y);
	initial begin
		x=1'b0;y=1'b0;
	    #20	x=1'b0;y=1'b1;
	    #20 x=1'b1;y=1'b0;
	    #20 x=1'b1;y=1'b1;	
	end
	initial #100 $finish;
endmodule