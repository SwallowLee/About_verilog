module Lab2_ripple_borrow_4_bit_sub(output[3:0]Diff,output Bout,input[3:0] x,y,input Bin);
	wire borrow1,borrow2,borrow3;
	Lab2_full_sub M1(Diff[0],borrow,x[0],y[0],Bin);
	Lab2_full_sub M2(Diff[1],borrow2,x[1],y[1],borrow);
	Lab2_full_sub M3(Diff[2],borrow3,x[2],y[2],borrow2);
	Lab2_full_sub M4(Diff[3],Bout,x[3],y[3],borrow3);
endmodule