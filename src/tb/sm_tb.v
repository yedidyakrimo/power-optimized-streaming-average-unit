/* sm_tb.v - testbench example
	Author: Nir Sever
	Description:
	  The test bench:
		- Set the variables to known initial values
		- Executes a reset sequence
		- Run the clock
		- Start recording waveform data and monitors changes on the variables
		- Execute few up and down counting scenarios
*/

module sm_tb;
  parameter WIDTH = 5;
  reg clk;
  reg rst_n;
  reg act;
  reg up_dwn_n;
  wire [WIDTH-1:0] count;
  wire ovflw;

  // Place the DUT
  sm #(WIDTH) DUT (.clk(clk),.rst_n(rst_n),.act(act),.up_dwn_n(up_dwn_n),.count(count),.ovflw(ovflw));

  // Set initial values, value monitoring and reset sequence
  initial begin
    $display("Running Example");
    clk = 1'b1;
	rst_n = 1'b0; // Activate asynchronous reset
	act = 1'b0;
	up_dwn_n = 1'b1;

  	// Monitor changes
	$monitor("%t: rst_n=%b act=%b up_dwn_n=%b count=%d ovflw=%b\n",$time,rst_n,act,up_dwn_n,count,ovflw);

	#100 rst_n = 1'b1; // After 100 time steps, release reset
  end

  // Start toggling clock (change every 5 - clock cycle is 10)
  always
	#5 clk = ~clk;

  // Activate up and down counting sequences
  initial begin
	// @100, Start counting up until overflow
	#100 act = 1'b1;
	     up_dwn_n = 1'b1;

	// Reset (10 cycles pulse)
	#1000 rst_n = 1'b0;
	      act = 1'b0;
	#100 rst_n = 1'b1;
	// Do a count-up to 4 and then count-down to ovflw
	#100 act = 1'b1;
	     up_dwn_n = 1'b1;
	#40 up_dwn_n = 1'b0;
  end
endmodule

