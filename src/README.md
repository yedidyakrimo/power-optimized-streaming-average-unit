# Source Files

This directory contains all RTL source code and testbenches for the Power-Optimized Streaming Average Unit.

## Directory Structure

### rtl/
RTL (Register Transfer Level) design files:
- **average.v** - Top-level streaming average computation unit
- **sum.v** - Accumulator module for streaming data
- **sm.v** - State machine module
- **div.sv** - Division unit (provided by course)
- **div_wrapper.sv** - Wrapper for division unit

### tb/
Testbenches for verification:
- **average_tb.sv** - Main testbench for RTL simulation
- **glv_tb.sv** - Gate-level verification testbench
- **sum_tb.sv** - Testbench for accumulator module
- **sm_tb.v** - State machine testbench

## File Lists

The root `src/` directory also contains `.txt` file lists for simulation:
- `dut_src_list_avg.txt` - Files for average module simulation
- `dut_src_list_sum.txt` - Files for sum module simulation
- `dut_src_list_glv.txt` - Files for gate-level verification
- `dut_src_list_pwr.txt` - Files for power analysis
- `dut_src_list_example.txt` - Example file list

## Usage

These files are referenced by simulation scripts in the `scripts/` directory. Refer to the main [README](../README.md) for complete build and simulation instructions.
