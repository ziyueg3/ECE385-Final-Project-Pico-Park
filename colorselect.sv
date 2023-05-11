module colorselect (input logic find_blue,find_red, isinretangle,isbutton,findplatform,finddoor,
						  input logic [3:0] now_color_back,now_color_blueman,now_color_redman,now_color_door,now_color_graph,
						  input logic [2:0] statenumber,
						  //input logic doorblue,doorred,
						  output logic[3:0] now_color);
						
				parameter[3:0] orange=3;
				parameter[3:0] red=0;
					
					
					always_comb begin
						if(statenumber==3'b001)
							begin
								now_color = now_color_graph;
							end
						else if(find_blue&(now_color_blueman!=4'h02))
							begin
								now_color = now_color_blueman;
							end
						else if(~find_blue & find_red&(now_color_redman!=4'h02))
							begin
								now_color = now_color_redman;
							end
						else if(findplatform)
							begin
								now_color=red;
							end
						else if(isbutton)
							begin
								now_color=red;
							end
						else if(isinretangle)
							begin
								now_color=orange;
							end
						else if (finddoor)
							begin
								now_color = now_color_door;
							end
						else
							begin
								now_color = now_color_back;
							end
					end
						  

						  
						  
						  
endmodule  