module Lab2_half_sub_behavior(output reg D,B,input x,y);
	always@(x,y)begin
		if(x==0&&y==0) begin
				B=0;D=0;
			       end
		else if(x==0&&y==1) begin
					B=1;D=1;
				    end
		else if(x==1&&y==0) begin
					B=0;D=1;
				    end
		else if(x==1&&y==1) begin
					B=0;D=0;
				    end
	end
endmodule