module statemachine(	input Clk,Reset,
							input logic [7:0] keycode0,keycode1,
							input logic [11:0] ballxblue,ballyblue,ballxred,ballyred,zerox,
							
							//output logic doorblue,doorred,
							output logic [2:0]statenumber
							);
							
							enum logic [2:0] {A, B, C, D, E, F}   curr_state, next_state; 

	//updates flip flop, current state is the only one
	
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= A;
        else 
            curr_state <= next_state;
    end
	logic door;
	parameter [11:0] doorleft = 2416;
	parameter [11:0] doorright = 2476;
	//parameter [11:0] doorup = 96;
	//parameter [11:0] doordown = 176;
		 // Assign outputs based on state
	 always_comb
		begin
			if(((ballxblue-20>=doorleft)&(ballxblue+20<=doorright)&(keycode0==8'h0d))|((ballxred-20>=doorleft)&(ballxred+20<=doorright)&(keycode0==8'h51)))
				begin
					door= 1;
				end
			else
				begin
					door =0;
				end
		
		
		end
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (keycode0==8'h28)
                       next_state = B;
            B :    if (keycode0!=8'h28)
							  next_state = C;
            C :    if (door==1)
							  next_state = D;
            D :    //if (keycode0!=8'h0d)
							  next_state = A;
            /*E :    next_state = F;
				F :    next_state = G;
				G :    next_state = H;
				H :    next_state = I;
				I :    next_state = J;
            J :    if (~Execute) 
                       next_state = A;*/
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A: 
	         begin
               statenumber =3'b001 ;
		      end
	   	   B: 
		      begin
               statenumber =3'b001 ;
		      end
				C: 
	         begin
               statenumber =3'b010 ;
		      end
	   	   D: 
		      begin
               statenumber =3'b010 ;
		      end
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
              statenumber =3'b011 ;
		      end
        endcase
    end
endmodule  