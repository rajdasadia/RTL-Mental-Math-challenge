//Author Raj Dasadia
// 6370
// Homework 4
// 4014
// load register with reset and clock trigger

module loadreg ( clk, reset, load, fourBitIn, fourBitOut );

input clk, reset, load;
input [3:0] fourBitIn; 
output [3:0] fourBitOut;
reg [3:0] fourBitOut;

always @ (posedge clk)

begin 
	if ( reset == 1)
	 begin
	  if ( load == 1)
	    begin
	     fourBitOut = fourBitIn;
	    end
	  end
	else if (reset == 0)
	 begin
	   fourBitOut = 4'b0000;
	 end
end 
endmodule

