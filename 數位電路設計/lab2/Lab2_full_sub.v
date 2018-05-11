`include "Lab2_half_sub_gatelevel.v"

module Lab2_full_sub(output D,B,input x,y,z);
	wire first_D,first_B,second_B;
	Lab2_half_sub_gatelevel M1(first_D,first_B,x,y);
	Lab2_half_sub_gatelevel M2(D,second_B,first_D,z);
	or(B,second_B,first_B);
endmodule