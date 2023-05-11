module moving_control(input logic 
							 output logic );
							 
							 
			
			ball ball1( .Reset(Reset_h),
						 .frame_clk(VGA_VS),
						 .keycode0(keycode0),
						 .keycode1(keycode1),
						 .BallX(ballxsig),
						 .BallY(ballysig),
						 .BallS(ballsizesig)
						 .Ballxmax,
						 .Ballymax,
						 .Ballxmin,
						 .Ballymin
						 .upkeycode
						 .downkeycode
						 .jumpkeycode
						 .x_initial
						 .y_initial );
			ball ball2( .Reset(Reset_h),
						 .frame_clk(VGA_VS),
						 .keycode0(keycode0),
						 .keycode1(keycode1),
						 .BallX(ballxsig),
						 .BallY(ballysig),
						 .BallS(ballsizesig)
						 .Ballxmax,
						 .Ballymax,
						 .Ballxmin,
						 .Ballymin
						 .upkeycode
						 .downkeycode
						 .jumpkeycode
						 .x_initial
						 .y_initial );
			block block1(.BallX1
						  .BallY1
						  .BallS1
						  .BallX2
						  .BallY2
						  .BallS2
						  .Ball1xmax
						  .Ball2xmax
						  
			           );
			
			
			
			

endmodule 