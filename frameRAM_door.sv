module frameRAM_door
(
	input [3:0] data_in,
	input [12:0]write_address, read_address,
	input logic [11:0] zerox,
	input logic [9:0]drawx,drawy,
	input we,Clk,
	
	output logic [3:0] data_out,
	output logic finddoor
);

logic [3:0] mem [0:4799];

initial
begin
	$readmemh("door.txt",mem);
end

always_ff @ (posedge Clk) begin
		if(we)
			mem[write_address] <= data_in;
		data_out <= mem[read_address];
end

logic[11:0]nowx,nowy;
assign nowx={2'b00,drawx}+zerox;
assign nowy={2'b00,drawy};


//parameter [9:0] doorx = 2416;
//parameter [9:0] doory = 96;
parameter [11:0] doorleft = 2416;
parameter [11:0] doorright = 2476;
parameter [11:0] doorup = 96;
parameter [11:0] doordown = 176;

always_comb begin
if((nowx>=doorleft)&(nowx<=doorright)&(nowy<=doordown)&(nowy>=doorup))
	begin
		finddoor=1;
	end
else
	begin
		finddoor=0;
	end
end
endmodule  