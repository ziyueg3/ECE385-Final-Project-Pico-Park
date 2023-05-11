module frameRAM_graph
(
	input [3:0] data_in,
	input [16:0]write_address, read_address,
	input we,Clk,
	
	output logic [3:0] data_out
);

logic [3:0] mem [0:76799];

initial
begin
	$readmemh("startpage3.txt",mem);
end

always_ff @ (posedge Clk) begin
		if(we)
			mem[write_address] <= data_in;
		data_out <= mem[read_address];
end

endmodule