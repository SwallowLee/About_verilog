primitive Lab1_UDP(ABC,A,B,C);
	output ABC;
	input A,B,C;
	table
     	     // A B C  : ABC
		1 1 1  : 0;
		1 1 0  : 0;
		1 0 1  : 1;
		1 0 0  : 1;
		0 1 1  : 1;
		0 1 0  : 0;	
		0 0 1  : 1;
		0 0 0  : 0;
	endtable
endprimitive