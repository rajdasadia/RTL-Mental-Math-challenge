// Raj Dasadia
// Homework 2
//  4014
// detects if the input is a binary 1111
module hexFdetector (hex_in, out_sigRed, out_sigGreen);

input [3:0] hex_in;
output out_sigRed, out_sigGreen;

reg out_sigRed, out_sigGreen;

	always @ (hex_in)
		if (hex_in == 4'b1111)
		  begin
			out_sigGreen = 1; out_sigRed = 0;
		  end
		else
		  begin
			out_sigRed = 1; out_sigGreen = 0;
		  end
	
endmodule
