/* sm.v - state machine example - 4 bit up/down counter
	Author: Nir Sever
	Description:
	sm implements a state machine for controlling a 4 bit counter
	The counter will count up when both act and up_dwn_n are asserted high
	The counter will count down when act is asserted high and up_dwn_n is deasserted
	When act is deasserted, the counter goes into and IDLE state (not counting)
	When the counter overflows or underflows is goes into an error condition which c
	an be exited only with asserting rst_n to low
*/
module sm #(parameter COUNTER_WIDTH = 4) (clk,rst_n,act,up_dwn_n,count,ovflw);
  // Inputs
  input clk;   // Clock signal
  input rst_n; // Low activated async reset
  input act;   // Chip enable
  input up_dwn_n;  // Count up = 1, Count down = 0
  // Outputs
  output [COUNTER_WIDTH-1:0] count;  // Counter
  output ovflw;  // Overflow signal
  // Regs
  reg [COUNTER_WIDTH-1:0] count;
  reg [3:0] state,next_state;
  // One-hot Enumeration of the States
  localparam IDLE  = 4'b0001;
  localparam CNTUP = 4'b0010;
  localparam CNTDN = 4'b0100;
  localparam OVFLW = 4'b1000;

// Combinational block - compute next state
  always @*
	case (state)
	  IDLE: begin
		if (act)
		  if (up_dwn_n) 
             next_state = CNTUP;
		  else    // if !up_dwn_n
             next_state = CNTDN;
		else  // if !act
		  next_state = IDLE;
		end // IDLE
	  CNTUP: begin
		if (act)
		  if (up_dwn_n)  // count up
		    if (count==(1<<COUNTER_WIDTH)-1) // counter overflow
			  next_state = OVFLW;
		    else   // valid count up
			  next_state = CNTUP;
		  else   // count down
		    if (count==4'b0000)  // counter negative overflow
			  next_state = OVFLW; 
		    else  // valid count down
			  next_state = CNTDN;
		  else   // !act
		    next_state = IDLE;
		end  // CNTUP
	  CNTDN: begin
		if (act)
		  if (up_dwn_n)  // count up
		    if (count==(1<<COUNTER_WIDTH)-1)  // counter overflow
			  next_state = OVFLW;
		    else  // valid count up
			  next_state = CNTUP;
		  else // count down
		    if (count==4'b0000)
			  next_state = OVFLW; // counter negative overflow
 		    else  // valid count down
			  next_state = CNTDN;
		  else // !act
		    next_state = IDLE;
	    end // CNTDN
	  OVFLW: begin
		  next_state = OVFLW; // Once in overflow, stay in overflow
	    end
	  default: begin
		   next_state = 4'bx;
		   $display("%t: State machine not initialized\n",$time);
		 end
	endcase

  always @(posedge clk or negedge rst_n)
	if (!rst_n) 
	   state <= IDLE;
	else 
	   state <= next_state;

  always @(posedge clk or negedge rst_n)
	if (!rst_n) 
	   count <= 'b0000;
	else if (state==CNTUP) 
	   count <= count+1'b1;
	else if (state==CNTDN) 
	   count <= count-1'b1;

  assign ovflw = (state==OVFLW) ? 1'b1 : 1'b0;

endmodule

