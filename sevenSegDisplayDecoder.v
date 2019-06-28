//Author Raj Dasadia
// 6370
// Homework 2
// 4014
// Displays 4 bit binary into 7 segment display device
module sevenSegDisplayDecoder (fourbit_in, sevenbit_out);

input [3:0] fourbit_in;
output [6:0] sevenbit_out;
reg [6:0] sevenbit_out;

	always @ (fourbit_in)
		begin
			case (fourbit_in)
				4'b0000:
				begin
					sevenbit_out = 7'b1000000;
				end	
				4'b0001:
				begin
					sevenbit_out = 7'b1001111;
				end	
				4'b0010:
				begin
					sevenbit_out = 7'b0100100;
				end	
				4'b0011:
				begin
					sevenbit_out = 7'b0110000;
				end	
				4'b0100:
				begin
					sevenbit_out = 7'b0011001;
				end	
				4'b0101:
				begin
					sevenbit_out = 7'b0010010;
				end	
				4'b0110:
				begin
					sevenbit_out = 7'b0000010;
				end	
				4'b0111:
				begin
					sevenbit_out = 7'b1111000;
				end	
				4'b1000:
				begin
					sevenbit_out = 7'b0000000;
				end	
				4'b1001:
				begin
					sevenbit_out = 7'b0010000;
				end	
				4'b1010:
				begin
					sevenbit_out = 7'b0001000;
				end	
				4'b1011:
				begin
					sevenbit_out = 7'b0000011;
				end	
				4'b1100:
				begin
					sevenbit_out = 7'b1000110;
				end	
				4'b1101:
				begin
					sevenbit_out = 7'b0100001;
				end	
				4'b1110:
				begin
					sevenbit_out = 7'b0000110;
				end	
				4'b1111:
				begin
					sevenbit_out = 7'b0001110;
				end	
				default:
				begin
					sevenbit_out = 7'b0000000;
				end
			endcase
		end
endmodule

				

			