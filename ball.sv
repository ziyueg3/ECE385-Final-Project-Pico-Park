//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk,
					input [7:0] keycode0,keycode1,keycode2,keycode3,keycodeleft,keycoderight,keycodejump,
					input logic[9:0] drawX,drawY,
					input logic movex,movey,testjump,
					input logic[11:0] Ball_X_Center,Ball_Y_Center,
					input logic[11:0] zerox,
					input logic[11:0] otherx,othertestx,//otherx is the other ball's BallX, othertestx is the other ball's testballX. //12.1 new add
					input logic istop, othermovex, //othermovex is the other ball's movex //12.1 new add
               input logic [11:0] platform,
					input logic platon,
					output [11:0]  BallX, BallY, BallS,
					output logic find,
					output logic[11:0] testballx,testbally,Ball_v,
					output logic[9:0] findballx,findbally,
					output logic x_direction,jump);//x: 0 is left ,1 is right.
    
    logic [11:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos,Ball_Y_Motion, Ball_v_Motion,Ball_a,Ball_a_Motion, Ball_Size,Ball_X_Pos_new,Ball_Y_Pos_new,Ballt,Ballfollow,deltax;
	 logic [7:0] oldkeycode,newkeycode,keycodechange;
	 logic jump_Motion,jump1,jump2,jump3;
	 
    //parameter [9:0] Ball_X_Center=500;  // Center position on the X axis
    //parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [11:0] Ball_X_Min=20;       // Leftmost point on the X axis
    parameter [11:0] Ball_X_Max=620;     // Rightmost point on the X axis
    parameter [11:0] Ball_Y_Min=25;       // Topmost point on the Y axis
    parameter [11:0] Ball_Y_Max=455;     // Bottommost point on the Y axis
    parameter [11:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [11:0] Ball_Y_Step=1;      // Step size on the Y axis
	 parameter [11:0] Ball_g=1; 
	 parameter [11:0] Ball_speed=-16; 

    assign Ball_Size = 20;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign deltax=othertestx-otherx;
	 //assign deltay=othertesty-othery;
	 always_comb begin
	 if ((istop==1)&(othermovex==1))
		begin
			Ballfollow=deltax;
		end
	 else
		begin 
			Ballfollow=0;
		end
	end
		
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
		  
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				//Ball_t <= 10'd0;
				Ball_v <= 10'd0;
				keycodechange=8'h00;
				jump_Motion<=0;
				x_direction<=1;
				//testballx <=Ball_X_Center;
				//testbally <= Ball_Y_Center;
				//jump<=0;
        end
           
        else 
        begin
				//Ball_Y_Pos_new <= BallY;
				//Ball_X_Pos_new <= BallX;
				/*if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  begin
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  oldkeycode=8'h1A;
					  end
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  begin
					  Ball_Y_Motion <= Ball_Y_Step;
					  oldkeycode=8'h16;
					  end
				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					  begin
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  oldkeycode=8'h04;
					  end
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
					  begin
					  Ball_X_Motion <= Ball_X_Step;
					  oldkeycode=8'h07;
					  end
				 else 
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
				*/	  
				 /*if(keycode!=newkeycode)
				 begin*/
				 //case (keycode0)
					if(keycode0==keycodeleft) begin

								Ball_X_Motion <= -1;//A
								Ball_Y_Motion<= Ball_v;
								Ball_v_Motion<=Ball_g;
								jump1<=0;
								x_direction<=0;
							
								//keycodechange=keycodechange;
								//Ball_a_Motion<=0;
								//oldkeycode=keycode;
							  end
					        
					//8'h07 : begin
					else if(keycode0==keycoderight) begin
								
					        Ball_X_Motion <= 1;//D
							  Ball_Y_Motion <= Ball_v;
							  Ball_v_Motion <=Ball_g;
							  jump1<=0;
							  x_direction<=1;
							  //keycodechange=keycodechange;
							  //Ball_a_Motion <=0;
							  //oldkeycode=keycode;
							  end

					//8'h2c :
					else if (keycode0==keycodejump) begin
							 if ((jump1==0)&(testjump==1))
							 begin
							  Ball_X_Motion <= 0;//D
							  Ball_Y_Motion <=Ball_speed ;     
							  Ball_v_Motion <=Ball_speed ;
							  jump1<=1;
							  //keycodechange=8'h2c;
							  end
							  else
							  begin
							  Ball_Y_Motion <= Ball_v;//nothing
							  Ball_X_Motion <= 0;
							  Ball_v_Motion <=Ball_g;
							  jump1<=0;
							  //keycodechange=8'h2c;
							 //oldkeycode=keycode;
							 end
							  
							  //Ball_a_Motion <=Ball_g;
							  end
					/*8'h16 : begin

					        Ball_Y_Motion <= 1;//S
							  Ball_X_Motion <= 0;
							  //oldkeycode=keycode;
							 end
							  
					8'h1A : begin
					        Ball_Y_Motion <= -1;//W
							  Ball_X_Motion <= 0;
							  //oldkeycode=keycode;
							 end*/
							 
					//default:
				   else	
							begin
							 Ball_Y_Motion <= Ball_v;//nothing
							 Ball_X_Motion <= 0;
							 Ball_v_Motion <=Ball_g;
							 jump1<=0;
							 //keycodechange=keycodechange;
							 //keycodechange=8'h00;
							 //oldkeycode=keycode;
							 end	  
			   //endcase
				
			   //case(keycode1)
					//8'h04 : 
					jump3<=0;
					
					if((keycode1==keycodeleft)|(keycode2==keycodeleft)|(keycode3==keycodeleft)) begin

								Ball_X_Motion <= -1;//A
								x_direction<=0;
								jump3<=0;
								//Ball_Y_Motion<= Ball_v;
								//Ball_v_Motion<=Ball_g;
								end
					        
					//8'h07 : 
					if((keycode1==keycoderight)|(keycode2==keycoderight)|(keycode3==keycoderight)) begin
								
					         Ball_X_Motion <= 1;//D
							   x_direction<=1;
								jump3<=0;
							  //Ball_Y_Motion <= Ball_v;
							  //Ball_v_Motion <=Ball_g;
							  //jump_Motion<=0;
							  end

					//8'h2c :
					if ((keycode1==keycodejump)|(keycode2==keycodejump)|(keycode3==keycodejump)) begin
							 if ((jump3==0)&(testjump==1))
							 begin
							  //Ball_X_Motion <= 0;//D
							  Ball_Y_Motion <=Ball_speed ;     
							  Ball_v_Motion <=Ball_speed ;
							  jump3<=1;
							  end
							  else
							  jump3<=0;
							  
							  
							  //Ball_a_Motion <=Ball_g;
							  end
					
							 
					//else 
							
				
				
				//endcase
				
			
				//end
				 
				 
				 //jump<=jump|jump_Motion;
				 //Ball_v <= (Ball_v+Ball_v_Motion);
				 
				 //Ball_a <= Ball_a+Ball_a_Motion;
				 //Ball_t <= Ball_t+1;
				 //newkeycode=oldkeycode;
				if(Ball_X_Pos+Ball_X_Motion-zerox > Ball_X_Max)
						Ball_X_Pos <=Ball_X_Max+zerox;
				else if(Ball_X_Pos+Ball_X_Motion-zerox<Ball_X_Min)
						Ball_X_Pos <=Ball_X_Min+zerox;
				else if(movex) 
						Ball_X_Pos <= Ball_X_Pos + Ball_X_Motion+Ballfollow;
				else
						Ball_X_Pos <= Ball_X_Pos;
				/*else 
						Ball_X_Pos<=Ball_X_Pos_new;*/
						
						
						
						
				if (Ball_Y_Pos+ Ball_Y_Motion >= Ball_Y_Max)
				begin
						Ball_Y_Pos<=Ball_Y_Min;
						//Ball_v <= 10'd0;
						jump2<=0;
						//Ball_X_Motion <= 0;
						//keycodechange=8'h00;
						Ball_v <= Ball_v_Motion;
						//Ball_a <= 10'd0;
				end
				else if(Ball_Y_Pos+ Ball_Y_Motion < Ball_Y_Min)
				begin
						Ball_Y_Pos <= Ball_Y_Min;
						Ball_v <= Ball_v_Motion;
						
						jump2<=0;
						//keycodechange=8'h2c;
						//Ball_a <= 10'd0;
				end
				
				else if(movey)
				begin
						Ball_Y_Pos <= Ball_Y_Pos + Ball_Y_Motion; 
						Ball_v <= (Ball_v+Ball_v_Motion);
						jump2<=0;
				end
				else if(jump)
				begin
						Ball_v=(Ball_v+Ball_v_Motion);
						jump2<=1;
				end
				else if(platon)
				begin
						Ball_Y_Pos <= platform; 
						Ball_v <= Ball_v_Motion ;
						jump2<=0;
				end
				else
				begin
						Ball_Y_Pos <= Ball_Y_Pos; 
						Ball_v <= Ball_v_Motion ;
						jump2<=0;
				
				end
				
				
				
				
				
				
				 //jump<=jump|jump_Motion;
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end
		
    end
	 
	        
		
		assign BallX=Ball_X_Pos;
		//assign jump=~movey;
		assign BallY=Ball_Y_Pos;
		assign jump=jump1|jump2|jump3;
		assign testbally = (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
		assign testballx = (Ball_X_Pos + Ball_X_Motion);
		
		/*always_comb begin
			if (Bal)
		endcase 
	end*/
	
		assign BallS = Ball_Size;
	
		parameter [9:0] Ballxsize = 20;//20;
		parameter [9:0] Ballysize = 25;//25;
		parameter [9:0] Ballxsizeneg = -20;
		parameter [9:0] Ballysizeneg = -25;
		int cal1,cal2;
		
		assign cal1=drawX-(BallX-zerox);
		assign cal2=drawY-BallY;
		
		
		always_comb begin
		//if(((drawX-BallX)<Ballxsize)&&((drawX-BallX)>Ballxsizeneg)&&((drawY-BallY)<Ballysize)&&((drawY-BallY)>Ballysizeneg))
		if((cal1*cal1<Ballxsize*Ballxsize)&(cal2*cal2<Ballysize*Ballysize))//&(cal1>Ballxsizeneg)&(cal2>Ballysizeneg))	
			begin
				find =1'b1;
			end
		else
			begin
				find =1'b0;
			end
							
		
		
		end
		assign findballx =Ballxsize+(drawX-(BallX-zerox));
		assign findbally =Ballysize+(drawY-BallY);

			
	 
	 
	 
	 //assign BallS = Ball_Size;
	 
	 
	 /*always_comb 
	 begin
	 if (((Ball_Y_Pos + Ball_Size) < Ball_Y_Max)&&( (Ball_Y_Pos - Ball_Size) > Ball_Y_Min ))
		 begin
		 BallY = Ball_Y_Pos;
		 BallX= BallX;
		 end
	 else;
		 
	 end
	 
	 always_comb
	 begin
    if( ((Ball_X_Pos + Ball_Size) < Ball_X_Max )&&( (Ball_X_Pos - Ball_Size) > Ball_X_Min ) )
		 begin
		 BallX = Ball_X_Pos;
		 BallY= BallY;
		 end
	else ;
			
		
		
	 end*/
endmodule
