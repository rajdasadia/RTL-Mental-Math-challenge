// Raj Dasadia
// Homework 2
// 4014
// Adds two 4 bit numbers
module fourBitAdder (in1, in2, sum);

input [3:0] in1, in2;
output [3:0] sum;
reg [3:0] sum;
	always @ (in1, in2)
	 begin 
	  
	     sum = in1 + in2;
	   
	 end
endmodule
