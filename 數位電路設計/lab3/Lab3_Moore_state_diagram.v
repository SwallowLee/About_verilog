module Lab3_Moore_state_diagram(output reg y,input x,clock,reset);
	reg [1:0] state,next;
	parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;
	wire A,B;
	always @(posedge clock,negedge reset)
		if(reset==0) state<=S0;
		else state<=next;
	always @(state,x)
		case(state)
			S0:if(x) next=S0;else next=S1;
			S1:if(x) next=S2;else next=S1;
			S2:if(x) next=S3;else next=S1;
			S3:if(x) next=S0;else next=S1;
		endcase
	always @(state,x)
	begin
		case(state)
			S3:y=1;
			S0,S1,S2:y=0;
		endcase
	end
endmodule