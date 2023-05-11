module frameRAM2
(
	input [3:0] data_in,
	input [9:0] testballx, testbally,
	input [18:0]write_address, read_address,
	input we,Clk,
	
	output logic [3:0] data_out,
	output logic movex,movey
);

logic [3:0] mem [0:307199];
logic [18:0] test_up,test_down,test_left,test_right;

initial
begin
	$readmemh("background2.txt",mem);
end

/*always_ff @ (posedge Clk) begin
		if(we)
			mem[write_address] <= data_in;
		data_out <= mem[read_address];
end*/


always_ff @ (posedge Clk) begin
	test_up <= testballx + (testbally-25)*640;
	test_down <= testballx + (testbally+25)*640;
	test_left <= (testballx+20) + testbally*640;
	test_right <= (testballx-20) + testbally*640;
	
	if((mem[test_up]!= 3'b010) || (mem[test_down]!= 3'b010))
		begin
			movex <=1'b0;
		end
	else
		begin
			movex <=1'b1;
		end
	
	if((mem[test_left]!= 3'b010) || (mem[test_right]!= 3'b010))
		begin
			movey <=1'b0;
		end
	else
		begin
			movey <=1'b1;
		end
		
end

endmodule  