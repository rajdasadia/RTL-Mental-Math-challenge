// Author Raj Dasadia
// RNG which makes use of generic counter by just instantiating it and assigning it an external button

module randomNumGenerator (clk, reset, b_in, count);
input clk, reset;
input b_in;
output [3:0] count;
assign b_in_inverted = ~b_in;

counter rng_counter (clk, reset, b_in_inverted, count);

endmodule