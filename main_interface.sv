module main_interface(input logic  Clk,Reset,
							 input logic  [7:0] keycode0,keycode1,keycode2,keycode3,
							 /*input  logic AVL_READ,					// Avalon-MM Read
	                   input  logic AVL_WRITE,					// Avalon-MM Write
	                   input  logic AVL_CS,					// Avalon-MM Chip Select
	                   input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	                   input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	                   input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	                   output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
							 */
							 output logic [7:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	                   output logic hs, vs, blank	
							);
							
	parameter[9:0] length=640;
	parameter[9:0] length_ball_blue=40;
	parameter[9:0] length_ball_red=40;
   logic[11:0] x_blue,x_red,y_blue,y_red;
	assign x_blue=12'b000100101100;//300
	assign y_blue=12'b000011110000;//240
	assign x_red =12'b000011110000;//240
	assign y_red =12'b000010001100;//140
	logic sync, VGA_Clk;
	logic [9:0] drawx, drawy;
	logic [11:0] ballxsig_blue, ballysig_blue,ballxsig_red, ballysig_red, ballsizesig;
	logic [9:0] findbally_blue,findballx_blue;
	logic [11:0] testballx_blue,testbally_blue,Ball_v_blue;
	logic [9:0] findbally_red,findballx_red,finddoorx,finddoory;
	logic [11:0] testballx_red,testbally_red,Ball_v_red;
	logic [12:0] now_position_back,now_position_blueman,now_position_redman,now_position_door;
	logic [3:0] now_color_back,now_color_blueman,now_color_redman,now_color,now_color_door;
	logic [7:0]  bkg_red, bkg_green, bkg_blue,ball_red,ball_blue,ball_green;
	logic find_blue,find_red;
	logic movex1,movey1;
	logic test_jump_blue,test_jump_red,jump_blue,jump_red;
	logic movex_blue,movey_blue,movex_red,movey_red;//background controller
	logic x_direction_blue,x_direction_red;
	logic displacex_blue,displacex_red;//character relation controller
	logic displacey_blue,displacey_red;
	logic edgemovexblue,edgemovexred;//edge controller
	logic [11:0] zeropointx;//x coordinate edge
	logic bluexmove,redxmove;//total controller
	logic isinrectangle,isbutton,stopblue_y,stopred_y;
	logic  findplatform,platonblue,platonred;
   logic [11:0]platform;
	logic	finddoor;
	logic [2:0]statenumber;
	logic [16:0] now_position_graph;
	logic [3:0] now_color_graph;
	logic istop_blue,istop_red;
	logic doorblue,doorred;
	
	parameter [3:0] minification = 16;
	
	
	//logic [18:0]index;
	assign movex1=1'b1;
	assign movey1=1'b0;
	//total controller
	assign bluexmove=movex_blue & displacex_blue & edgemovexblue;
	assign redxmove=movex_red & displacex_red & edgemovexred;
	assign blueymove=movey_blue & displacey_blue &(~stopblue_y)&(~platonblue);
	assign redymove=movey_red & displacey_red &(~stopred_y)&(~platonred);

	assign jump_blue=(test_jump_blue)|(stopblue_y)|(platonblue)|istop_blue;
	assign jump_red =(test_jump_red)|(stopred_y)|(platonred)|istop_red;


	
	//moving_control  moving();
	//backgroundstore  background();
	//collor_mapper   color(); 
	
	/*always_comb begin
		if(find_blue)
			begin
				now_color = now_color_blueman;
			end
		else if(~find_blue & find_red)
			begin
				now_color = now_color_redman;
			end
		else
			begin
				now_color = now_color_back;
			end
	end*/
	
	
/*	
	always_comb begin
		case(find_blue)
		 1'b0: now_color=now_color_back;
		 1'b1: now_color=now_color_blueman;
		 default: now_color=now_color_blueman;
		endcase
	end
	
	always_comb begin
		case(find_red)
		 1'b0: now_color=now_color_back;
		 1'b1: now_color=now_color_redman;
		 default: now_color=now_color_redman;
		endcase
	end
*/	
	logic reset_rect,resets;
	always_comb begin
	if (keycode0 == 8'h16)
		begin
			resets=1;
		end
	else
		begin
			resets= 0;
		end
	end
	logic reset_zero,resete;
	always_ff@(posedge vs) begin
	if (keycode0 == 8'h28)
		begin
			resete <=1;
		end
	else
		begin
			resete <=0;
		end
	end
	
	assign reset_zero= Reset|resete;
	//assign now_position_back = (drawy/minification) * (length /minification*4) + (drawx)/minification;	
	assign now_position_back = (drawy/16) * 160 + (drawx+zeropointx)/16;
	assign now_position_graph = (drawy/2) * 320 + drawx/2;
	assign now_position_blueman = findbally_blue * length_ball_blue + findballx_blue;
	assign now_position_redman = findbally_red * length_ball_red + findballx_red;	
	//assign now_color_back=4'b0010;
	
   /*ram0 background(.address(now_position),
					  .clock(Clk),
					  .data(),
					  .rden(1'b1),
					  .wren(1'b0),
					  .q(now_color)				  					
						); 
	*/
	colorselect choose(.find_blue(find_blue),
					       .find_red(find_red), 
							 .finddoor(finddoor),
							 .isinretangle(isinrectangle),
							 .isbutton(isbutton),
							 .findplatform(findplatform),
						    .now_color_back(now_color_back),
							 .now_color_blueman(now_color_blueman),
							 .now_color_redman(now_color_redman),
							 .now_color_door(now_color_door),
							 .now_color_graph(now_color_graph),
							 .statenumber(statenumber),
						    .now_color(now_color));
	
	frameRAM background(.data_in(),
					  .write_address(),
					  .read_address(now_position_back),
					  .testballx_blue(testballx_blue),
					  .testbally_blue(testbally_blue),
					  .test_jump_blue(test_jump_blue),
					  .Ball_v_blue(Ball_v_blue),
					  .x_direction_blue(x_direction_blue),
					  .movex_blue(movex_blue),
					  .movey_blue(movey_blue),
					  .testballx_red(testballx_red),
					  .testbally_red(testbally_red),
					  .test_jump_red(test_jump_red),
					  .Ball_v_red(Ball_v_red),
					  .x_direction_red(x_direction_red),
					  .movex_red(movex_red),
					  .movey_red(movey_red),
					  .zeropointx(zeropointx),
					  .we(1'b0),
					  .Clk(Clk),
					  .data_out(now_color_back)
					  );
	
	/*
	frameRAM background(.data_in(),
					  .write_address(),
					  .read_address(now_position_back),
					  .testballx(testballx),
					  .testbally(testbally),
					  .test_jump(test_jump),
					  .Ball_v(Ball_v),
					  .x_direction(x_direction),
					  .keycode0(keycode0),
					  .keycode1(keycode1),
					  .movex(movex),
					  .movey(movey),
					  .we(1'b0),
					  .Clk(Clk),
					  .data_out(now_color_back)
					  );
					  
	*/

	character1RAM  blueman(.data_in(),
					  //.write_address(),
					  .read_address(now_position_blueman),
					  //.we(1'b0),
					  .Clk(Clk),
					  .x_direction(x_direction_blue),
					  .jump(jump_blue),
					  .data_out(now_color_blueman));		
	
	character2RAM  redman(.data_in(),
					  //.write_address(),
					  .read_address(now_position_redman),
					  //.we(1'b0),
					  .Clk(Clk),
					  .x_direction(x_direction_red),
					  .jump(jump_red),
					  .data_out(now_color_redman));	
	
	
	vga_controller vga( .Clk(Clk), 
								 .Reset(Reset), 
								 .hs(hs),
								 .vs(vs), 
								 .pixel_clk(VGA_Clk),
								 .blank(blank),
								 .sync(sync),
								 .DrawX(drawx),
								 .DrawY(drawy) );
	color_finder  colors(.color(now_color),
								.red(red),
								.green(green),
								.blue(blue),);
	/*findball     finder (.drawX(drawx),  //module which is used to find whether drawing pixel is in the Ball scale
								 .drawY(drawy),
								 //.CLK(Clk),
								 .BallX(ballxsig),
								 .BallY(ballysig),
								 .find(find),
								 .findballx(findballx),
								 .findbally(findbally)
	                      );*/
	ball ballblue( .Reset(reset_zero),
						 .frame_clk(vs),
						 .keycode0(keycode0),
						 .keycode1(keycode1),
						 .keycode2(keycode2),
						 .keycode3(keycode3),
						 .keycodeleft(8'h0b),//H
						 .keycoderight(8'h0e),//K
						 .keycodejump(8'h18),//U
						 .BallX(ballxsig_blue),
						 .BallY(ballysig_blue),
						 //.BallS(ballsizesig),
						 .drawX(drawx),  //module which is used to find whether drawing pixel is in the Ball scale
						 .drawY(drawy),
						 .find(find_blue),
						 .findballx(findballx_blue),
						 .findbally(findbally_blue),
						 .movex(bluexmove),
						 .movey(blueymove),
						 //.movex(edgemovexblue),
						 //.movey(movey1),
						 .testballx(testballx_blue),
						 .testbally(testbally_blue),
						 .Ball_v(Ball_v_blue),
						 .testjump(jump_blue),
						 .x_direction(x_direction_blue),
						 //.jump(jump_blue),
						 .Ball_X_Center(x_blue),
						 .Ball_Y_Center(y_blue),
						 .zerox(zeropointx),
						 .otherx(ballxsig_red),
						 .othertestx(testballx_red),
						 .othermovex(redxmove),
						 .platform(platform),
						 .platon(platonblue),
						 .istop(istop_blue)
						 );
 ball ballred( .Reset(reset_zero),
						 .frame_clk(vs),
						 .keycode0(keycode0),
						 .keycode1(keycode1),
						 .keycode2(keycode2),
						 .keycode3(keycode3),
						 .keycodeleft(8'h50),
						 .keycoderight(8'h4f),
						 .keycodejump(8'h52),
						 .BallX(ballxsig_red),
						 .BallY(ballysig_red),
						 //.BallS(ballsizesig),
						 .drawX(drawx),  //module which is used to find whether drawing pixel is in the Ball scale
						 .drawY(drawy),
						 .find(find_red),
						 .findballx(findballx_red),
						 .findbally(findbally_red),
						 .movex(redxmove),
						 .movey(redymove),
						 //.movex(edgemovexblue),
						 //.movey(movey1),
						 .testballx(testballx_red),
						 .testbally(testbally_red),
						 .Ball_v(Ball_v_red),
						 .testjump(jump_red),
						 .x_direction(x_direction_red),
						 //.jump(jump_red),
						 .Ball_X_Center(x_red),
						 .Ball_Y_Center(y_red),
						 .zerox(zeropointx),
						 .otherx(ballxsig_blue),
						 .othertestx(testballx_blue),
						 .othermovex(bluexmove),
						 .platon(platonred),
						 .platform(platform),
						 .istop(istop_red)
						 );
character_relation relation(.testballx_blue(testballx_blue),
									.testbally_blue(testbally_blue),
									.Ball_v_blue(Ball_v_blue),
									.testballx_red(testballx_red),
									.testbally_red(testbally_red),
									.Ball_v_red(Ball_v_red),
									.ballxsig_blue(ballxsig_blue), 
									.ballysig_blue(ballysig_blue),
									.ballxsig_red(ballxsig_red), 
									.ballysig_red(ballysig_red),
									.x_direction_blue(x_direction_blue),
									.test_jump_blue(jump_blue),
									.x_direction_red(x_direction_red),
									.test_jump_red(jump_red),
									
									.displacex_blue(displacex_blue),
									.displacex_red(displacex_red),
									.displacey_blue(displacey_blue),
									.displacey_red(displacey_red),
									.istop_blue(istop_blue),
									.istop_red(istop_red)
									);
edge_control edge_control(.ball_x_blue(testballx_blue),
								  .ball_x_red(testballx_red),
								  .Reset(reset_zero),
								  .Clk(vs),
								  .zeropointx(zeropointx),
								  .edgemovexblue(edgemovexblue),
								  .statenumber(statenumber),
								  .edgemovexred(edgemovexred)
								);

leftmoverectangle rectangle(.ballxblue(testballx_blue),
									 .ballxred(testballx_red),
									 .ballyblue(testbally_blue),
									 .ballyred(testbally_red),//the two ball's testballx and testbally(12.1)
		               		 .Clk(vs),
									 .Reset(reset_zero),//The  Clk as the ball (12.1)
		                      .drawx(drawx),
									 .drawy(drawy),//the drawx and drawy
		                      .zeropoint(zeropointx), 
	                         .isinrectangle(isinrectangle), //the signal which judges whether the pixel drawing is in rectangle   color:0      							 
		                      .isbutton(isbutton), //						 
		                      .stopblue_y(stopblue_y),
									 .stopred_y(stopred_y)						 
								 );
						 
platform    plata( .Clk(vs),
						.Reset(reset_zero),
					   .ballxblue(testballx_blue),
						.ballyblue(testbally_blue),
						.ballxred(testballx_red),
						.ballyred(testbally_red),
						.oldballxblue(ballxsig_blue),
						.oldballyblue(ballysig_blue),
						.oldballxred(ballxsig_red),
						.oldballyred(ballysig_red),
						.zerox(zeropointx),
					   .drawx(drawx),
						.drawy(drawy),
					   .findplatform(findplatform),
					   .platonblue(platonblue),
						.platonred(platonred), 
						.platform(platform)
						);
//parameter [9:0] doorxsize = ;//20;
//parameter [9:0] doorysize = 25;//25;
parameter [9:0] doorx = 2416;//20;
parameter [9:0] doory = 96;//25;
//parameter [9:0] Ballxsizeneg = -20;
//parameter [9:0] Ballysizeneg = -25;

		
assign finddoorx =drawx-(doorx-zeropointx);
assign finddoory =drawy-doory;

assign now_position_door = finddoory * 60 + finddoorx;



frameRAM_door door(	.data_in(),
							.write_address(), 
							.read_address(now_position_door),
							.zerox(zeropointx),
							.drawx(drawx),
							.drawy(drawy),
							.we(1'b0),
							.Clk(Clk),
							.data_out(now_color_door),
							.finddoor(finddoor)
							);
frameRAM_graph enter(.data_in(),
							.write_address(), 
							.read_address(now_position_graph),
							//.drawx(drawx),
							//.drawy(drawy),
							.we(1'b0),
							.Clk(Clk),
							.data_out(now_color_graph),
							);
statemachine statemachine(	.Clk(Clk),
									.Reset(Reset),
									.keycode0(keycode0),
									.keycode1(keycode1),
									.ballxblue(ballxsig_blue),
									.ballyblue(ballysig_blue),
									.ballxred(ballxsig_red),
									.ballyred(ballysig_red),
									.zerox(zeropointx),
									//.doorblue(doorblue),
									//.doorred(doorred),
									.statenumber(statenumber)
									);
/*sign red  = 8'hff;
assign green=8'hff;
assign blue=8'hff;*/
endmodule  