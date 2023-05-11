module findball(input logic[9:0] drawX,drawY,BallX,BallY,
					//input logic CLK,
					output logic find,
					output logic[9:0] findballx,findbally);
					parameter [9:0] Ballxsize = 20;//20;
					parameter [9:0] Ballysize = 25;//25;
					parameter [9:0] Ballxsizeneg = -20;
					parameter [9:0] Ballysizeneg = -25;
					int cal1,cal2;
					
					assign cal1=drawX-BallX;
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
					assign findballx =Ballxsize+(drawX-BallX);
				   assign findbally =Ballysize+(drawY-BallY);
					
					
endmodule  