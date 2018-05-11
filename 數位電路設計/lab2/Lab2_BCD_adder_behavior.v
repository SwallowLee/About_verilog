module Lab2_BCD_adder_behavior(output reg[3:0] Sum,output reg Cout,input[3:0] A,B,input Cin);
	reg out,out1,out2;
	always@(A,B,Cin) begin
		if(A+B+Cin>9)
			begin
				Sum=A+B+Cin-10;
				Cout=1;
			end
		else
			begin
				Sum=A+B+Cin;
				Cout=0;
			end
	end
endmodule