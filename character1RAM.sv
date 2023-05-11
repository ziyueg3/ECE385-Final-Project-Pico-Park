module character1RAM
(
	input [3:0] data_in,
	input [18:0]read_address,//write_address, 
	input Clk,Reset,//we,
	input logic x_direction,jump,
	
	output logic [3:0] data_out
);

logic [3:0] mem_stand_right [0:1999];
logic [3:0] mem_stand_left  [0:1999];
logic [3:0] mem_jump_right  [0:1999];
logic [3:0] mem_jump_left   [0:1999];

initial
begin
	$readmemh("blue_stand_right.txt",mem_stand_right);
	$readmemh("blue_stand_left.txt",mem_stand_left);
	$readmemh("blue_jump_right.txt",mem_jump_right);
	$readmemh("blue_jump_left.txt",mem_jump_left);
end

always_ff @ (posedge Clk) begin
		//if(we)
		//	mem[write_address] <= data_in;
		
		if(~jump & x_direction)
			begin
				data_out <= mem_jump_right[read_address];
			end
		else if(~jump & ~x_direction)
			begin
				data_out <= mem_jump_left[read_address];
			end
		else if(jump & ~x_direction)
			begin
				data_out <= mem_stand_left[read_address];
			end
		else
			begin
				data_out <= mem_stand_right[read_address];
			end
end

endmodule