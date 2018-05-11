`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:11 09/24/2015 
// Design Name: 
// Module Name:    sub 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
// ------------- A eight-bit full adder ------------------------------ 
module sub(a, b, S);
input [7:0] a, b;
output [8:0] S;
wire [8:0]x;
wire y, z, w;
assign x = 9'd1;
assign y = 1'b0;
wire [8:0]ta, tb, tc, td;
assign ta[0] = a[0];
assign ta[1] = a[1];
assign ta[2] = a[2];
assign ta[3] = a[3];
assign ta[4] = a[4];
assign ta[5] = a[5];
assign ta[6] = a[6];
assign ta[7] = a[7];
assign ta[8] = a[7];

assign tb[0] = b[0];
assign tb[1] = b[1];
assign tb[2] = b[2];
assign tb[3] = b[3];
assign tb[4] = b[4];
assign tb[5] = b[5];
assign tb[6] = b[6];
assign tb[7] = b[7];
assign tb[8] = b[7];
Com bc(.B(tb), .S(tc));
FullAdder fa(.A(tc), .B(x), .Cin(y), .S(td), .Cout(z));
FullAdder sum(.A(ta), .B(td), .Cin(y), .S(S), .Cout(w));

endmodule
module FullAdder(A, B, Cin, S, Cout);
input [8:0] A, B;
input Cin;
output [8:0] S;
output Cout;
wire [7:0] t;


FA_1bit FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(t[0]));
FA_1bit FA1(.A(A[1]), .B(B[1]), .Cin(t[0]), .S(S[1]), .Cout(t[1]));
FA_1bit FA2(.A(A[2]), .B(B[2]), .Cin(t[1]), .S(S[2]), .Cout(t[2]));
FA_1bit FA3(.A(A[3]), .B(B[3]), .Cin(t[2]), .S(S[3]), .Cout(t[3]));
FA_1bit FA4(.A(A[4]), .B(B[4]), .Cin(t[3]), .S(S[4]), .Cout(t[4]));
FA_1bit FA5(.A(A[5]), .B(B[5]), .Cin(t[4]), .S(S[5]), .Cout(t[5]));
FA_1bit FA6(.A(A[6]), .B(B[6]), .Cin(t[5]), .S(S[6]), .Cout(t[6]));
FA_1bit FA7(.A(A[7]), .B(B[7]), .Cin(t[6]), .S(S[7]), .Cout(t[7]));
FA_1bit FA8(.A(A[8]), .B(B[8]), .Cin(t[7]), .S(S[8]), .Cout(Cout));

endmodule

// ----------------- A 1-bit full adder ----------------------------- 
module FA_1bit(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
assign S = Cin ^ A ^ B;
assign Cout = (A & B) | (Cin & B) | (Cin & A);
endmodule

// ----------------------Complement -------------------------

module Com(B, S);
input [8:0]B;
output [8:0]S;
assign S[0] = !B[0];
assign S[1] = !B[1];
assign S[2] = !B[2];
assign S[3] = !B[3];
assign S[4] = !B[4];
assign S[5] = !B[5];
assign S[6] = !B[6];
assign S[7] = !B[7];
assign S[8] = !B[8];
endmodule
