module Lab1_dataflow (F,A,B,C,D);
	input A,B,C,D;
	output F;
	wire wireAB,wireAC,wireBD,wireABC;
	assign wireAB=A&~B;
	assign wireAC=C&~A;
	assign wireBD=B^~D;
	assign wireABC=wireAB^wireAC;
	assign F=wireABC&wireBD;
endmodule