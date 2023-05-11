module frameRAM
(
	input [3:0] data_in,
	input [11:0] testballx_blue,testbally_blue,Ball_v_blue,
	input [11:0] testballx_red,testbally_red,Ball_v_red,
	input [12:0]write_address, read_address,
	input logic we,Clk,x_direction_blue,jump_blue,x_direction_red,jump_red,
	input [11:0] ballxsig_blue, ballysig_blue,ballxsig_red, ballysig_red,
	input [9:0] zeropointx,
	//input [7:0] keycode0,keycode1,
	
	output logic [3:0] data_out,
	output logic test_jump_blue,test_jump_red,
	output logic movex_blue,movey_blue,movex_red,movey_red
);

logic [3:0] mem [0:4799];//30*（40*4）
logic [12:0] test_up_blue,test_down_blue,test_left1_blue,test_right1_blue,test_left2_blue,test_right2_blue,test_up1_blue,test_down1_blue,test_up2_blue,test_down2_blue;
logic [12:0] test_up_red,test_down_red,test_left1_red,test_right1_red,test_left2_red,test_right2_red,test_up1_red,test_down1_red,test_up2_red,test_down2_red;
//logic [9:0] velocity;
logic [12:0] y_direction_blue,y_direction_red;

assign y_direction_blue = testbally_blue - ballysig_blue;//>0 down
assign y_direction_red  = testbally_red  - ballysig_red ;//>0 down

logic [3:0] x_minification,y_minification;
logic [7:0] x_pixel;

assign x_minification = 16;
assign y_minification = 16;
assign x_pixel = 160;

/*
parameter [3:0] x_minification = 16;
parameter [3:0] y_minification = 16;
parameter [7:0] x_pixel = 160;
*/

initial
begin
	$readmemh("background_new.txt",mem);
end

always_ff @ (posedge Clk) begin
		if(we)
			mem[write_address] <= data_in;
		data_out <= mem[read_address];
end


//always_ff @ (posedge Clk) begin
always_comb begin
	/*
	if(jump)
		begin
			velocity = Ball_v-15;
		end
	else
		begin
			velocity = Ball_v;
		end
	
	test_up = testballx/8 + (testbally+velocity+1-25)/8*80;
	test_down = testballx/8 + (testbally+velocity+1+25)/8*80;
	test_left = (testballx-20)/8 + (testbally+velocity+1)/8*80;
	test_right = (testballx+20)/8 + (testbally+velocity+1)/8*80;
	*/
	
	/*
	test_up_blue = testballx_blue/x_minification + (testbally_blue-25)/y_minification*x_pixel;
	test_down_blue = testballx_blue/x_minification + (testbally_blue+25)/y_minification*x_pixel;
	
	test_up1_blue = (testballx_blue-19)/x_minification + (testbally_blue-25)/y_minification*x_pixel;
	test_down1_blue = (testballx_blue-19)/x_minification + (testbally_blue+25)/y_minification*x_pixel;
	test_up2_blue = (testballx_blue+19)/x_minification + (testbally_blue-25)/y_minification*x_pixel;
	test_down2_blue = (testballx_blue+19)/x_minification + (testbally_blue+25)/y_minification*x_pixel;
	
	test_left1_blue = (testballx_blue-20)/x_minification + (testbally_blue+24)/y_minification*x_pixel;
	test_right1_blue = (testballx_blue+20)/x_minification + (testbally_blue+24)/y_minification*x_pixel;
	test_left2_blue = (testballx_blue-20)/x_minification + (testbally_blue-24)/y_minification*x_pixel;
	test_right2_blue = (testballx_blue+20)/x_minification + (testbally_blue-24)/y_minification*x_pixel;
	
	
	test_up_red = testballx_red/x_minification + (testbally_red-25)/y_minification*x_pixel;
	test_down_red = testballx_red/x_minification + (testbally_red+25)/y_minification*x_pixel;
	
	test_up1_red = (testballx_red-19)/x_minification + (testbally_red-25)/y_minification*x_pixel;
	test_down1_red = (testballx_red-19)/x_minification + (testbally_red+25)/y_minification*x_pixel;
	test_up2_red = (testballx_red+19)/x_minification + (testbally_red-25)/y_minification*x_pixel;
	test_down2_red = (testballx_red+19)/x_minification + (testbally_red+25)/y_minification*x_pixel;
	
	test_left1_red = (testballx_red-20)/x_minification + (testbally_red+24)/y_minification*x_pixel;
	test_right1_red = (testballx_red+20)/x_minification + (testbally_red+24)/y_minification*x_pixel;
	test_left2_red = (testballx_red-20)/x_minification + (testbally_red-24)/y_minification*x_pixel;
	test_right2_red = (testballx_red+20)/x_minification + (testbally_red-24)/y_minification*x_pixel;
	*/
	//if((mem[testballx/8 + (testbally+2+25)/8*80]!= 4'b0010) & (mem[testballx/8 + (testbally-25)/8*80] == 4'b0010))
	
	
	test_up_blue = testballx_blue/16 + (testbally_blue-25)/16*160;
	test_down_blue = testballx_blue/16 + (testbally_blue+25)/16*160;
	
	
	test_up1_blue = (testballx_blue-19)/16 + (testbally_blue-25)/16*160;
	test_down1_blue = (testballx_blue-19)/16 + (testbally_blue+25)/16*160;
	test_up2_blue = (testballx_blue+19)/16 + (testbally_blue-25)/16*160;
	test_down2_blue = (testballx_blue+19)/16 + (testbally_blue+25)/16*160;
	
	test_left1_blue = (testballx_blue-20)/16 + (testbally_blue+24)/16*160;
	test_right1_blue = (testballx_blue+20)/16 + (testbally_blue+24)/16*160;
	test_left2_blue = (testballx_blue-20)/16 + (testbally_blue-24)/16*160;
	test_right2_blue = (testballx_blue+20)/16 + (testbally_blue-24)/16*160;
	
	
	test_up_red = testballx_red/16 + (testbally_red-25)/16*160;
	test_down_red = testballx_red/16 + (testbally_red+25)/16*160;
	
	
	test_up1_red = (testballx_red-19)/16 + (testbally_red-25)/16*160;
	test_down1_red = (testballx_red-19)/16 + (testbally_red+25)/16*160;
	test_up2_red = (testballx_red+19)/16 + (testbally_red-25)/16*160;
	test_down2_red = (testballx_red+19)/16 + (testbally_red+25)/16*160;
	
	test_left1_red = (testballx_red-20)/16 + (testbally_red+24)/16*160;
	test_right1_red = (testballx_red+20)/16 + (testbally_red+24)/16*160;
	test_left2_red = (testballx_red-20)/16 + (testbally_red-24)/16*160;
	test_right2_red = (testballx_red+20)/16 + (testbally_red-24)/16*160;
	
	
	if((mem[test_down1_blue]!= 4'b0010) |(mem[test_down2_blue]!= 4'b0010) & (mem[test_up_blue] == 4'b0010))
		begin
			test_jump_blue = 1'b1;
		end
	else
		begin
			test_jump_blue = 1'b0;//0
		end
	
		
	if(y_direction_blue>0)
		begin
			if((mem[test_down1_blue] == 4'b0010)&(mem[test_down2_blue] == 4'b0010))
				begin
					movey_blue = 1'b1;
				end
			else
				begin
					movey_blue = 1'b0;//0
				end
		end
	else
		begin		
			if((mem[test_up1_blue] == 4'b0010)&(mem[test_up2_blue] == 4'b0010))
				begin
					movey_blue = 1'b1;
				end
			else
				begin
					movey_blue = 1'b0;//0
				end
		end
	/*
	else
		begin
			movey = 1'b0;
			//movey = 1'b1;for test.
		end
	*/
	
	
	if(x_direction_blue)
		begin
			if((mem[test_right1_blue] == 4'b0010)&(mem[test_right2_blue] == 4'b0010))
				begin
					movex_blue =1'b1;
				end
			else
				begin
					movex_blue =1'b0;//0
				end
		end
	else
		begin
			if((mem[test_left1_blue] == 4'b0010)&(mem[test_left2_blue] == 4'b0010))
				begin
					movex_blue =1'b1;
				end
			else
				begin
					movex_blue =1'b0;//0
				end
		end	
	
	
		if((mem[test_down1_red]!= 4'b0010) | (mem[test_down2_red]!= 4'b0010)& (mem[test_up_red] == 4'b0010))
		begin
			test_jump_red = 1'b1;
		end
	else
		begin
			test_jump_red = 1'b0;//0
		end
	
		
	if(y_direction_red>0)
		begin
			if((mem[test_down1_red] == 4'b0010)&(mem[test_down2_red] == 4'b0010))
				begin
					movey_red = 1'b1;
				end
			else
				begin
					movey_red = 1'b0;//0
				end
		end
	else
		begin		
			if((mem[test_up1_red] == 4'b0010)&(mem[test_up2_red] == 4'b0010))
				begin
					movey_red = 1'b1;
				end
			else
				begin
					movey_red = 1'b0;//0
				end
		end
	/*
	else
		begin
			movey = 1'b0;
			//movey = 1'b1;for test.
		end
	*/
	
	
	if(x_direction_red)
		begin
			if((mem[test_right1_red] == 4'b0010)&(mem[test_right2_red] == 4'b0010))
				begin
					movex_red =1'b1;
				end
			else
				begin
					movex_red =1'b0;//0
				end
		end
	else
		begin
			if((mem[test_left1_red] == 4'b0010)&(mem[test_left2_red] == 4'b0010))
				begin
					movex_red =1'b1;
				end
			else
				begin
					movex_red =1'b0;//0
				end
		end
	
	/*
	if((mem[test_up] == 4'b0010)&(mem[test_down] == 4'b0010))
		begin
			movey =1'b1;
		end
	else
		begin
			movey =1'b0;
		end
	
	if((mem[test_left] == 4'b0010)&(mem[test_right] == 4'b0010))
		begin
			movex =1'b1;
		end
	else
		begin
			movex =1'b0;
		end
	*/	
end
endmodule