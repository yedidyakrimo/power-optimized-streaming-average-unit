###################################################################
# SDC Constraints File for Module: average
# Fixed version: Hardcoded values to avoid Tcl variable errors
# Target Clock Period: 2.0ns
###################################################################

# 1. Set Current Design
current_design average

# 2. Clock Definition
# We manually set the period to 2.0ns as per your target
create_clock -name "clk" -period 2.0 [get_ports clk]

# 3. Clock Constraints (Uncertainty & Transition)
# Values taken from your original defines (0.125ns and 0.25ns)
set_clock_uncertainty 0.125 [get_clocks clk]
set_clock_transition 0.25 [get_clocks clk]

# 4. Ideal Networks
# Clock and Reset are treated as ideal (no delay calculation) during synthesis
set_ideal_network [get_ports {clk rst_n}]

# 5. Input and Output Delays
# Delay is 0.66ns (approx 30% of cycle)
# We exclude the clock port itself from the input list
set_input_delay 0.66 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 0.66 -clock clk [all_outputs]

# 6. Design Rule Constraints (DRV) and Loads
# Max Fanout and Transition limits
set_max_fanout 16 [current_design]
set_max_transition 0.35 [current_design]

# Input transition and Output load (Standard estimations for 65nm)
set_input_transition 0.2 [all_inputs]
set_load 0.05 [all_outputs]

# Optional: Max delay for combinational paths (Feedthrough)
# Calculated as Period/2 + In_Delay + Out_Delay = 1.0 + 0.66 + 0.66 = ~2.32
# If you don't have pure combinational paths (In->Out), this line is optional but safe to keep.
set_max_delay 2.32 -from [all_inputs] -to [all_outputs]