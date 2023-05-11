module testbench();

timeunit 10ns;

timeprecision 1ns;

logic Clk = 0;


      ///////// Clocks /////////
logic     MAX10_CLK1_50; 

///////// KEY /////////
logic    [ 1: 0]   KEY;

///////// SW /////////
logic    [ 9: 0]   SW;

///////// LEDR /////////
logic   [ 9: 0]   LEDR;

///////// HEX /////////
logic   [ 7: 0]   HEX0;
logic   [ 7: 0]   HEX1;
logic   [ 7: 0]   HEX2;
logic   [ 7: 0]   HEX3;
logic   [ 7: 0]   HEX4;
logic   [ 7: 0]   HEX5;

///////// SDRAM /////////
logic             DRAM_CLK;
logic             DRAM_CKE;
logic   [12: 0]   DRAM_ADDR;
logic   [ 1: 0]   DRAM_BA;
logic    [15: 0]   DRAM_DQ;
logic             DRAM_LDQM;
logic             DRAM_UDQM;
logic             DRAM_CS_N;
logic             DRAM_WE_N;
logic             DRAM_CAS_N;
logic             DRAM_RAS_N;

///////// VGA /////////
logic             VGA_HS;
logic             VGA_VS;
logic   [ 3: 0]   VGA_R;
logic   [ 3: 0]   VGA_G;
logic   [ 3: 0]   VGA_B;


///////// ARDUINO /////////
logic    [15: 0]   ARDUINO_IO;
logic              ARDUINO_RESET_N; 

finaltop slc3_testtop(.*);

always begin : CLOCK_GENERATION
#1 MAX10_CLK1_50 = ~MAX10_CLK1_50;
end

initial begin : CLOCK_INITIALIZATION

   MAX10_CLK1_50 = 0;
 
end  
initial begin : TEST_VECTORS

     SW=0;

end 
endmodule  