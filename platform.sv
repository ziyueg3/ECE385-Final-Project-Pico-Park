module platform(input logic Clk,Reset,
					 input logic [11:0] ballxblue,ballyblue,ballxred,ballyred,zerox,oldballxblue,oldballyblue,oldballxred,oldballyred,
					 input logic [9:0]drawx,drawy,
					 output logic findplatform,
					 output logic platonblue,platonred,
					 output logic [11:0] platform 
					);
				parameter [11:0]platinitialy=431;
				parameter [11:0]platxright=2287;
				parameter [11:0]platxleft=2161;
				parameter [11:0]platx=2224;
				parameter [11:0]platfinaly=191;
				parameter [11:0]plattall=16;
			   logic [11:0] platup,platdown,ballblueleft,ballblueright,ballblueup,ballbluedown,ballredup,ballreddown,ballredleft,ballredright,oldballblueleft,oldballblueright,oldballblueup,oldballbluedown,oldballredup,oldballreddown,oldballredleft,oldballredright;
				
				assign platup=platdown-plattall;
				assign ballblueleft=ballxblue-20;
				assign ballblueright=ballxblue+20;
				assign ballredleft=ballxred-20;
				assign ballredright=ballxred+20;
				assign ballblueup =ballyblue-25;
				assign ballbluedown =ballyblue+25;
				assign ballredup =ballyred-25;
				assign ballreddown =ballyred+25;
				assign oldballblueleft=ballxblue-20;
				assign oldballblueright=ballxblue+20;
				assign oldballredleft=ballxred-20;
				assign oldballredright=ballxred+20;
				assign oldballblueup =ballyblue-25;
				assign oldballbluedown =ballyblue+25;
				assign oldballredup =ballyred-25;
				assign oldballreddown =ballyred+25;
				assign platform = platup-25;
				
				
				always_ff @(posedge Clk) begin
				if (Reset)
				 begin
					//platformx <=platx;
					platdown <=platinitialy;
					//platonblue <= 0;
					//platonred  <= 0;
				 end
				else
					if((ballblueleft<platxright)&(ballblueright>platxleft)&(ballredleft<platxright)&(ballredright>platxleft)&(ballbluedown>=platup)&(ballreddown>=platup))
						begin
							if((platdown-1)>=platfinaly)
								begin
									/*if((ballbluedown>=platup)&(ballbluedown<=platdown))
										begin
											platonblue<=1;
										end
									else
										begin
											platonblue<=0;
										end
									if((ballreddown>=platup)&(ballreddown<=platdown))
										begin
											platonred<=1;
										end
									else
										begin
											platonred<=0;
										end*/
									
									platdown <= platdown-1;
								end
							else
								begin
									/*if((ballbluedown>=platup)&(ballbluedown<=platdown))
										begin
											platonblue<=1;
										end
									else
										begin
											platonblue<=0;
										end
									if((ballreddown>=platup)&(ballreddown<=platdown))
										begin
											platonred<=1;
										end
									else
										begin
											platonred<=0;
										end*/
									//platdown=platdown;
									if((platdown+1)>=platinitialy)
										begin
											platdown<=platdown+1;
										end
									else
										begin
											platdown<=platdown;
										end
								end
						end
					else 
						begin
							
							/*if((ballbluedown>=platup)&(ballbluedown<=platdown)&(ballblueleft<platxright)&(ballblueright>platxleft))
								begin
									platonblue<=1;
								end
							else
								begin
									platonblue<=0;
								end
							if((ballreddown>=platup)&(ballreddown<=platdown)&(ballredleft<platxright)&(ballredright>platxleft))
								begin
									platonred<=1;
								end
							else
								begin
									platonred<=0;
								end*/
							if((platdown+1)<=platinitialy)
								begin
									platdown<=platdown+1;
								end
							else
								begin
									platdown<=platdown;
								end
						end
					end
					logic[11:0]nowx,nowy;
					assign nowx={2'b00,drawx}+zerox;
					assign nowy={2'b00,drawy};
					always_comb begin
						if((ballbluedown>=platup+2)&(ballblueup<=platdown)&(ballblueleft<platxright)&(ballblueright>platxleft))
								begin
									platonblue=1;
								end
							else
								begin
									platonblue=0;
								end
							if((ballreddown>=platup+2)&(ballredup<=platdown)&(ballredleft<platxright)&(ballredright>platxleft))
								begin
									platonred=1;
								end
							else
								begin
									platonred=0;
								end
						//if(ballbluedown<=platup)&(ballblueup<=platdown)&(ballblueleft<platxright)&(ballblueright>platxleft)
						if((nowx>=platxleft)&(nowx<=platxright)&(nowy<=platdown)&(nowy>=platup))//&(nowy<=platdown))
							begin
								findplatform=1;
							end
						else
							begin
								findplatform=0;
							end
						
					end

endmodule  
									
								
			