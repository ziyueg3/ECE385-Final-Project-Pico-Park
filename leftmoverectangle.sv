module leftmoverectangle(
		input logic[11:0] ballxblue,ballxred,ballyblue,ballyred,//the two ball's testballx and testbally(12.1)
		input logic Clk,Reset,//The  Clk as the ball (12.1)
		input logic [9:0] drawx,drawy,//the drawx and drawy
		input logic [11:0] zeropoint, 
	   output logic isinrectangle, //the signal which judges whether the pixel drawing is in rectangle   color:0      							 
		output logic isbutton, //						 
		output logic stopblue_y,stopred_y						 
								 );
		parameter[11:0] button_x_left=1808;
		parameter[11:0] button_x_right=1818;
		parameter[11:0] button_y=416;
		parameter[11:0] button_y_up=406;
		parameter[11:0] button_tall=10;
		parameter[11:0] leftbegin=1712;
		parameter[11:0] leftreset=1680;
		parameter[11:0] leftend=1568;
		parameter[11:0] rectangledown=447;
							
		logic [11:0] motion, ballblueleft,ballblueright,ballredleft,ballredright,ballybluedown,ballyreddown;
		assign ballblueleft  = ballxblue-20;
		assign ballblueright = ballxblue+20;
		assign ballredleft   = ballxred -20;
		assign ballredright  = ballxred +20;
		assign ballybluedown = ballyblue+30;
		assign ballyreddown  = ballyred +30;
		
		logic buttondown;
		logic [11:0] rectleft;
		always_ff@(posedge Clk) begin
			if (Reset)
			begin
				rectleft<=leftreset;
				motion <= 0;
				buttondown <=0;
			end
			else
			begin
				if ((ballblueleft<button_x_right)&(ballblueright>button_x_left)&(button_y<ballybluedown))
				begin
					motion <= 1;
					buttondown <=1;
				end
				else if ((ballredleft<button_x_right)&(ballredright>button_x_left)&(button_y<ballyreddown))
				begin
					motion <= 1;
					buttondown <=1;
				end
				else
				begin
					motion <=0;
					buttondown <=0;
				end
	
				
				if(((rectleft - motion)>leftend)&(motion==1))
				begin
				  rectleft <= rectleft - motion;
				end
				else
				begin
				  rectleft <= rectleft ;
				end
			end
		end
		
		logic[11:0] button_center_y;
	 	always_comb begin
		if(buttondown==1)// judge the position of button
			begin
				button_center_y = button_y;
			end
		else
			begin
				button_center_y = button_y_up;
			end
		
		
		//judge the fall of the ball
		 if((ballblueright>rectleft)&(ballblueleft<leftbegin)&(button_y<=(ballyblue+25)))
			begin
				stopblue_y=1;
				
			end
		 else
			begin
				stopblue_y=0;
			end
			
		 if((ballredright>rectleft)&(ballredleft<leftbegin)&(button_y<=(ballyred+25)))
			begin
				//stopblue_y=0;
				stopred_y =1;
			end
		 else
			begin
				//stopblue_y=0;
				stopred_y =0;
			end
			
	   
		//judge the color of button
		if((drawx+zeropoint>=button_x_left)&(drawx+zeropoint<=button_x_right)&(drawy>=button_center_y)&(drawy<=button_y))
			begin
				isbutton=1;
			end
		else
		  begin
				isbutton=0;
		  end
					
		//judge the color of the rectangle
		if((drawx+zeropoint>=rectleft)&(drawx+zeropoint <= leftbegin)&(drawy>=button_y)&(drawy<=rectangledown))
			begin
				isinrectangle=1;
			end
		else
			begin
				isinrectangle=0;
			end
	end
				
				
		
		
			
		 
			
								 
								 
endmodule  