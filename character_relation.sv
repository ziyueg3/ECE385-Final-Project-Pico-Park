module character_relation (
	input [11:0] testballx_blue,testbally_blue,Ball_v_blue,
	input [11:0] testballx_red,testbally_red,Ball_v_red,
	input [11:0] ballxsig_blue, ballysig_blue,ballxsig_red, ballysig_red,
	input logic x_direction_blue,test_jump_blue,x_direction_red,test_jump_red,
	
	output logic displacex_blue,displacex_red,displacey_blue,displacey_red,
	output logic istop_blue,istop_red
);

logic ismovex_blue,ismovex_red;
logic y_intersection,x_intersection;		//1 for has intersection, 0 for not
logic x_test1,x_test2;
logic y_test1,y_test2,y_test3,y_test4;

integer deltay;
assign deltay=testbally_blue-testbally_red;



always_comb begin
	if(testballx_blue == ballxsig_blue)
		begin
			ismovex_blue = 1'b0;
		end
	else
		begin
			ismovex_blue = 1'b1;
		end
	
	
	if(testballx_red == ballxsig_red)
		begin
			ismovex_red = 1'b0;
		end
	else
		begin
			ismovex_red = 1'b1;
		end

		
		
	//judgement on y intersection
	
	if(deltay < 52 & deltay >= 0)
		begin
			y_test1 = 1'b1;		//red on the top of blue
			y_test2 = 1'b0;
		end
	
	else if(deltay < 0 & deltay > -52)
		begin
			y_test1 = 1'b0;
			y_test2 = 1'b1;		//1//blue on the top of red
		end
	else
		begin
			y_test1 = 1'b0;
			y_test2 = 1'b0;
		end
		
		
	if(deltay < 50 & deltay >= 0)
		begin
			y_test3 = 1'b1;		//red on the top of blue
			y_test4 = 1'b0;
		end
	
	else if(deltay < 0 & deltay > -50)
		begin
			y_test3 = 1'b0;
			y_test4 = 1'b1;		//1//blue on the top of red
		end
	else
		begin
			y_test3 = 1'b0;
			y_test4 = 1'b0;
		end
	
	if(y_test3 | y_test4)
		begin
			y_intersection = 1'b1;		//y direction has interaction
		end
	else
		begin
			y_intersection = 1'b0;		//y direction do not have interaction
		end
	
	//judgement on x intersection
	if(testballx_blue-testballx_red < 40 & testballx_blue-testballx_red >= 0)
		begin
			x_test1 = 1'b1;
		end
	else
		begin
			x_test1 = 1'b0;
		end
	
	if(testballx_red-testballx_blue < 40 & testballx_red-testballx_blue >= 0)
		begin
			x_test2 = 1'b1;
		end
	else
		begin
			x_test2 = 1'b0;
		end
	
	if(x_test1 | x_test2)
		begin
			x_intersection = 1'b1;		//x direction has intersection
		end
	else
		begin
			x_intersection = 1'b0;		//x direction do not have intersection
		end
	
	
	if(x_intersection & y_test2 & test_jump_red)
		begin
			istop_blue = 1'b1;			//blue is on the top of red
			istop_red = 1'b0;
			displacey_blue = 1'b0;
			displacey_red = 1'b0;
		end
	else if (x_intersection & (deltay <= -52) & test_jump_red)
		begin
			istop_blue = 1'b0;
			istop_red = 1'b0;
			displacey_blue = 1'b1;//1
			displacey_red = 1'b0;
		end
	
	else if(x_intersection & y_test1 & test_jump_blue)
		begin
			istop_red = 1'b1;			//red is on the top of blue
			istop_blue = 1'b0;
			displacey_red = 1'b0;
			displacey_blue = 1'b0;
		end
	else if (x_intersection & (deltay >= 52) & test_jump_blue)
		begin
			istop_red = 1'b0;
			istop_blue = 1'b0;
			displacey_red = 1'b1;//1
			displacey_blue = 1'b0;
		end
	else 
		begin
			istop_blue = 1'b0;
			istop_red = 1'b0;
			displacey_red = 1'b1;//1
			displacey_blue = 1'b1;//1
		end
	
	
	
	if(y_intersection)
		begin
		if(ismovex_blue & ismovex_red)
			begin
			if(x_direction_blue & x_direction_red)//both right
			begin
			if(testballx_blue-testballx_red <= 40 & testballx_blue-testballx_red > 0)//red blue
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b0;
				end
				else if(testballx_red-testballx_blue <= 40 & testballx_red-testballx_blue > 0)//blue red
				begin
					displacex_blue = 1'b0;
					displacex_red  = 1'b1;//1
				end
				else
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b1;//1
				end
			end
			else if(x_direction_blue & ~x_direction_red)//blue right red left
			begin
				if(testballx_red-testballx_blue <= 40 & testballx_red-testballx_blue > 0)//blue red
				begin
					displacex_blue = 1'b0;
					displacex_red  = 1'b0;
				end
				else
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b1;//1
				end
			end
			else if(~x_direction_blue & x_direction_red)//blue left red right
			begin
				if(testballx_blue-testballx_red <= 40 & testballx_blue-testballx_red > 0)//red blue
				begin
					displacex_blue = 1'b0;
					displacex_red  = 1'b0;
				end
				else
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b1;//1
				end
			end
			else //both left
			begin
				if(testballx_blue-testballx_red <= 40 & testballx_blue-testballx_red > 0)//red blue
				begin
					displacex_blue = 1'b0;
					displacex_red  = 1'b1;//1
				end
				else if(testballx_red-testballx_blue <= 40 & testballx_red-testballx_blue > 0)//blue red
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b0;
				end
				else
				begin
					displacex_blue = 1'b1;//1
					displacex_red  = 1'b1;//1
				end
			end
		end
		
		else if (ismovex_blue & ~ismovex_red) //blue move red static
			begin
				if (x_direction_blue)//blue right
					begin
						if(testballx_red-testballx_blue <= 40 & testballx_red-testballx_blue > 0)
							begin
								displacex_blue = 1'b0;
								displacex_red  = 1'b1;
							end
						else
							begin
								displacex_blue = 1'b1;//1
								displacex_red  = 1'b1;
							end
					end
				else						//blue left
					begin
						if(testballx_blue-testballx_red <= 40 & testballx_blue-testballx_red > 0)
							begin
								displacex_blue = 1'b0;
								displacex_red  = 1'b1;
							end
						else
							begin
								displacex_blue = 1'b1;//1
								displacex_red  = 1'b1;
							end
					end
			end
		
		
		else if (~ismovex_blue & ismovex_red) //red move blue static
			begin
				if (x_direction_red)//red right
					begin
						if(testballx_blue-testballx_red <= 40 & testballx_blue-testballx_red > 0)
							begin
								displacex_blue = 1'b1;
								displacex_red  = 1'b0;
							end
						else
							begin
								displacex_blue = 1'b1;
								displacex_red  = 1'b1;
							end
					end
				else						//red left
					begin
						if(testballx_red-testballx_blue <= 40 & testballx_red-testballx_blue > 0)
							begin
								displacex_blue = 1'b1;
								displacex_red  = 1'b0;
							end
						else
							begin
								displacex_blue = 1'b1;
								displacex_red  = 1'b1;
							end
					end
			end
		else											// both static
			begin
				displacex_blue = 1'b1;
				displacex_red  = 1'b1;
			end
		end
	else											//if no intersection both can move in x direction
		begin
			displacex_blue = 1'b1;
			displacex_red  = 1'b1;
		end
end
endmodule