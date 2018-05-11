module t_Lab3_Moore;
	wire y1,y2;
	reg x,clock,reset;
	Lab3_Moore_state_diagram M1(y1,x,clock,reset);
	Lab3_Moore_structural M0(y2,x,clock,reset);
	initial #200 $finish;
	initial begin
		clock=0;
		forever #10 clock=~clock;
	end
initial fork
		reset = 0;x=0;
		#2 reset = 1;
		#100 reset = 0;
		#102 reset = 1;
		#40 x = 1;
		#80 x = 0;
		#120 x = 1;
		#160 x = 0;
		#200 x = 1;
	join
endmodule