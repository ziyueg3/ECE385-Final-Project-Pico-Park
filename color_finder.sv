module color_finder(input [3:0] color,
						  output [7:0]red,green,blue);
						  
logic [23:0] RGB;						  
always_comb
begin			
				case(color) 	
					4'b0000:
					begin
						RGB = 24'hff0000;
						/*red = 8'hff;
						green = 8'h00;
						blue = 8'h00;*/
					end
					4'b0001:
					begin
						RGB = 24'h000000;
						/*red = 8'h00;
						green = 8'h00;
						blue = 8'h00;*/
					end
					4'b0010:
					begin
						RGB = 24'hffffff;
						/*red = 8'hff;
						green = 8'hff;
						blue = 8'hff;*/
					end
					4'b0011:
					begin
						RGB = 24'hff864d;
						/*red = 8'hff;
						green = 8'h86;
						blue = 8'h4d;*/
					end
					4'b0100:
					begin
						RGB = 24'h7fbfff;
						/*red = 8'h7f;
						green = 8'hbf;
						blue = 8'hff;*/
					end
					4'b0101:
					begin
						RGB = 24'h517daa;
						/*red = 8'h51;
						green = 8'h7d;
						blue = 8'haa;*/
					end
					4'b0110:
					begin
						RGB = 24'hff8c8c;
						/*red = 8'hff;
						green = 8'h8c;
						blue = 8'h8c;*/
					end
					4'b0111:
					begin
						RGB = 24'haa5a5a;
						/*red = 8'haa;
						green = 8'h5a;
						blue = 8'h5a;*/
					end
					4'b1000:
					begin
						RGB = 24'hd0d000;
						/*red =  8'hd0;
						green = 8'hd0;
						blue = 8'h00;*/
					end
					4'b1001:
					begin
						RGB = 24'hdf9f7f;
						/*red = 8'hdf;
						green = 8'h9f;
						blue = 8'h7f;*/
					end
					default:
					begin
						RGB = 24'hffffff;
					   /*red = 8'hff;
						green = 8'hff;
						blue = 8'hff;*/
					end
					endcase
					
end
assign red   = RGB[23:16];
assign green = RGB[15:8];
assign blue  = RGB[7:0];
endmodule  