//Author Raj Dasadia
// Author 4014
//Generic Buttton Shaper using two procedure FSM

module singlePulseButton (b_in, pulse, clk, rst);

input b_in;
input clk, rst;

output pulse;

reg pulse;
reg [1:0] state, nextState;

parameter s_init = 0, s_pulse = 1, s_wait = 2;

always @ ( state, b_in)

	begin
	 
	 case (state)
	 
	   
	   s_init:
	    begin 
	     pulse = 0;
		if (b_in == 1)
		 begin
		  nextState = s_init;
		 end
		else
		 begin
		  nextState = s_pulse;
		 end
       	     end

	    s_pulse:
	     begin
	       pulse = 1;
	       nextState = s_wait;
	     end

	    s_wait:
	      begin
 		pulse = 0;
		  if (b_in == 0)
		    begin
		     nextState = s_wait;
		    end
		  else
		    begin
		     nextState = s_init;
		    end
	      end
 		
	     default:
	       begin
	         nextState = s_init;
	       end 
	   endcase
	end


always @ (posedge clk) 
	begin
	  if (rst == 0)
	    begin
	      state <= s_init;
	    end
	  else
	    begin
	      state <= nextState;
	    end
	 end

endmodule 