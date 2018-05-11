module Lab3_Moore_structural(output y,input x,clock,reset);
		wire TA,TB,A,B,ta,tb;
		xor(ta,A,B);
		and(TA,ta,x);
		and(tb,~B,A);
		or(TB,tb,~x);
		assign y=B&A;
		D_ff_AR M0(A,TA,clock,reset);
		D_ff_AR M1(B,TB,clock,reset);endmodule