module edge_control(input logic [11:0]ball_x_blue,ball_x_red,
						  input logic Reset,Clk,
						  input logic [2:0]statenumber,
						  output logic [11:0] zeropointx,
						  output logic edgemovexblue,edgemovexred
							);
			parameter [11:0] rightedge = 480;
			parameter [11:0] leftedge = 160;
			parameter [11:0] rightmax = 620;
			parameter [11:0] leftmax = 20;
			parameter [11:0] max= 1920;
			logic[11:0] ball_blue,ball_red;
			
			assign ball_blue=ball_x_blue-zeropointx;
			assign ball_red=ball_x_red-zeropointx;
				       
			always_ff @ (posedge Clk) begin
				if (Reset)
					begin
						zeropointx <= 0;
						edgemovexblue<=1;
						edgemovexred<=1;
						
					end
				else if (statenumber==3'b001)
					begin
						zeropointx <= 0;
						edgemovexblue<=1;
						edgemovexred<=1;
					end
			
			
			else begin
				if (((ball_blue >rightedge)&(ball_red>leftedge))|((ball_red >rightedge)&(ball_blue>leftedge))|((ball_blue >rightedge)&(ball_red>rightedge)))
					begin
						if(zeropointx<max)
							begin	
								zeropointx <= zeropointx+1;
								edgemovexblue <= 1'b1;
								edgemovexred  <= 1'b1;
							end
						else
							begin
								zeropointx<=zeropointx;
								edgemovexblue<=1'b1;
								edgemovexred <=1'b1;
							end
					end
				/*else if (((ball_blue >=rightmax)&(ball_red<leftmax))|((ball_red >=rightmax)&(ball_blue<leftmax)))
					begin
						zeropointx<=zeropointx;
						edgemovexblue <= 1'b0;
						edgemovexred  <= 1'b0;
					end*/
				else if(((ball_blue <rightedge)&(ball_red <leftedge))|((ball_red <rightedge)&(ball_blue <leftedge))|((ball_blue <leftedge)&(ball_red <leftedge)))
					begin		
						if (zeropointx>0)
							begin
								zeropointx<=zeropointx-1;
								edgemovexblue <= 1'b1;
								edgemovexred  <= 1'b1;
							end
						else
							begin
								zeropointx<=zeropointx;
								edgemovexblue <= 1'b1;
								edgemovexred  <= 1'b1;
							end
					end
				else
					begin
						zeropointx<=zeropointx;
						edgemovexblue<=1'b1;
						edgemovexred <=1'b1;
					end
			end
end
endmodule  