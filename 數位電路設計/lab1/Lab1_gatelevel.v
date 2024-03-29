module Lab1_gatelevel (F,A,B,C,D);
	input A,B,C,D;
	output F;
	wire wireAB,wireAC,wireBD,wireABC;
	and(wireAB,A,~B);
	and(wireAC,C,~A);
	or(wireBD,B,~D);
	or(wireABC,wireAB,wireAC);
	and(F,wireABC,wireBD);
endmodule