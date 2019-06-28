//Author Raj Dasadia
// State Machine for Password Authentication and Game Play
// Includes Pause, Resume timer reset and Logout feature

module access_control ( /*input*/   clk, reset, load_sig_RNG, load_sig_2,  load_password, pushButtonLoad_RNG, pushButtonLoad2, passinput4bit, timeout, 
/*output*/ reconfig, enable, passredled, passgreenled); 

input clk, reset;
input load_password;      //signal from button shaper
input [3:0] passinput4bit;
input pushButtonLoad_RNG, pushButtonLoad2 ;   //signal from button shaper
input timeout;

reg flag;
reg [3:0] state;
output load_sig_RNG, load_sig_2;  //signal to the load register
output passredled, passgreenled;
output reconfig, enable;
reg reconfig, enable;
reg passredled, passgreenled;
reg load_sig_RNG, load_sig_2 ;

///////////////////////////////////
//for internal timer1sec

reg enable_internal;
wire timeout_internal;
reg watchdogTimer;
///////////////////////////////////

parameter s1 = 0, s2 = 1, s3 = 2, s4 = 3, s5 = 4, s6 = 5, s7 = 6, s8 = 7, s9 = 8, s10 = 9, s11 = 10, s12 = 11, pause = 12, pause2 = 13, pause3 = 14;

//State s1 to s4 are the password authentication states
//State s5 determines if password is correct, if it is not go to s6 and then s1, if correct go to s7 and s8
//s8 is the timer reconfig state. s9 is the game ready state. s10 is the game begin state. 
//pause state is to indefinitely pause the game
//pause1 state is to determine if the player wants to log out or reconfigure the timer. pause3 is a buffer to logout state.
//s11 score determination. s12 buffer to timer reconfig state 

TimerOneSecond TimerOneSecond_internal (clk, reset, enable_internal, timeout_internal);

always @ (posedge clk)

 begin 

	if (reset == 0)
	 begin 
	  flag <=1;
	  load_sig_RNG <= 1;     
	  load_sig_2 <= 0;    
	  passredled <= 1;
	  passgreenled <= 0;
	  state <= s1;
	  enable <= 0;
	  enable_internal <= 0;
	 end
	else
	 begin
	 //////////////////////////
	 load_sig_RNG <= 1;
	 /////////////////////////
	  case (state)

	   s1:
	    begin
		passgreenled <= 0;
		passredled <= 1;
		enable_internal <= 0;
	     if (load_password == 1)
	      begin
	       if ( passinput4bit == 4'b0100)
		begin
		 state <= s2;
		 end 
		else
		 begin
		  flag <= 0;
		  state <= s2;
		 end
	        end
			else
		 begin
		  state <= s1;
		 end
	       end

	   s2:
	    begin
	     if (load_password == 1)
	      begin
	       if ( passinput4bit == 4'b0000)
		begin
		 state <= s3;
		 end 
		else
		 begin
		  flag <= 0;
		  state <= s3;
		 end
	        end
		else
		 begin
		  state <= s2;
		 end
	       end

	   s3:
	    begin
	     if (load_password == 1)
	      begin
	       if ( passinput4bit == 4'b0001)
		begin
		 state <= s4;
		 end 
		else
		 begin
		  flag <= 0;
		  state <= s4;
		 end
	        end
		else
		 begin
		  state <= s3;
		 end
	       end

	   s4:
	    begin
	     if (load_password == 1)
	      begin
	       if ( passinput4bit == 4'b0100)
		begin
		 state <= s5;
		 end 
		else
		 begin
		  flag <= 0;
		  state <= s5;
		 end
	        end
		else
		 begin
		  state <= s4;
		 end
	       end

	   s5:
	    begin
	     if (flag == 0)
	      begin
		 state <= s6;
	      end 
	       else
		 begin
		  state <= s7;
		 end
	        end

	   s6:
	    begin
	         flag <= 1;
		 state <= s1;
	    end 
	     
	


	   s7:
	    begin
	    passgreenled <= 1;
	    passredled <= 0;
		state <= s8;
	    end

	   s8:
	    begin
		enable_internal <= 0;
		if(load_password == 0)
			begin
				state <= s8;
				reconfig <= 0;
			end
		else 
			begin
				reconfig <= 1;
				state <= s9;
			end
	    end 
		
		s9:
		begin
			reconfig <= 0;
			if(load_password == 0)
				begin
					state <= s9;
				end
			else 
				begin
					state <= s10;
				end
		end
		
		s10:
		begin
			load_sig_RNG <= pushButtonLoad_RNG;                      
			load_sig_2 <= pushButtonLoad2;               
			enable <= 1;
			////////////////////////////////////////////////
			enable_internal <= 0;
			watchdogTimer <= 0;
			///////////////////////////////////////////////
			if(timeout == 1)
				begin
					state <= s11;
				end
			else 
				begin
					if(load_password == 1)
						begin
							enable_internal <= 1;
							state <= pause;
						end
					else
						begin
							state <= s10;
						end
				end
			
		end
////////////////////////////////////////////////////////////////////////	New feature	
		pause:
		begin
			load_sig_2 <=0;
			load_sig_RNG <= 1;
			enable <= 0;
			if(timeout_internal == 0)
				begin
					if(load_password == 1)
						begin 
							state <= pause2;
							enable_internal <= 0;
						end
					else
						begin
							state <= pause;
						end
				end
			else
				begin
					watchdogTimer <= 1;
					enable_internal <= 0;
				end
			if (watchdogTimer == 1)
				begin
					if(load_password == 1)
						begin 
							state <= s10;
						end
					else
						begin
							state <= pause;
						end
				end
							
				
		end
						
		pause2:
		begin
			watchdogTimer <= 0;
			enable_internal <= 1;
			if(timeout_internal == 0)
				begin
					if(load_password == 1)
						begin
							state <= pause3;
							enable_internal <= 0;
						end
					else
						begin
							state <= pause2;
						end
				end
			else
				begin
					state <= s8;
					reconfig <= 1;
				end
		end
		pause3:
		begin
			state <= s1;
		end
//////////////////////////////////////////////////////////////////////						
				
		s11: 
		begin
			enable <= 0;
			load_sig_RNG <= 1;
			load_sig_2 <= 0;
			if (load_password <= 0)
				begin
					state <= s11;
				end
			else
				begin
					state <= s12;
				end
		end
				
		s12:
		begin
			if (load_password <= 0)
				begin
					state <= s12;
				end
			else
				begin
					state <= s8;
				end
		end
  	   default:
	     begin
	      state <= s1;
	     end
        endcase
       end
 end
endmodule



