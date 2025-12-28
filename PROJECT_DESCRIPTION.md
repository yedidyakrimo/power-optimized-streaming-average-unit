# Power-Optimized Streaming Average Unit - Digital VLSI Design Project

## Executive Summary

This project implements a **Power-Optimized Streaming Average Unit** following industry-standard VLSI design flow. The design processes variable-length data streams, computes the arithmetic mean, and includes robust error handling with timeout mechanisms. The implementation demonstrates proficiency in RTL design, synthesis, gate-level verification, and power optimization using professional EDA tools, achieving 358.2 µW power consumption with 81% clock-gating coverage.

## Project Overview

**Design Goal:** Create a synthesizable RTL module that computes the average of a streaming sequence of 32-bit input values with proper control flow, error handling, and optimized power consumption.

**Key Features:**
- Streaming data processing with variable sequence lengths
- 3-state finite state machine (FSM) with timeout protection
- Integrated accumulator and division units
- Clock gating optimization for power efficiency
- Full verification flow from RTL to gate-level simulation

## Architecture

### Top-Level Module: `average`

The design consists of three main components:

1. **State Machine Controller**
   - States: `S_IDLE`, `S_WAIT`, `S_BUSY`
   - 10-cycle timeout mechanism for data arrival
   - Handles start signal, data flow control, and completion signaling

2. **Sum Module (`Sum_mod`)**
   - Streaming accumulator for variable-length sequences
   - Handles `data_first` and `data_last` signals
   - Outputs accumulated sum when sequence completes

3. **Division Module (`divu_int`)**
   - Unsigned integer division unit
   - Divides accumulated sum by element count
   - Includes divide-by-zero detection
   - Sequential algorithm with WIDTH-bit precision

### Design Parameters
- **Data Width:** 32 bits (parameterizable)
- **Clock Period:** 2.0 ns (500 MHz target)
- **Timeout:** 10 clock cycles
- **Technology:** TSMC65LP (65nm Low Power)

## Implementation Details

### RTL Design (Part 1)
- **Language:** SystemVerilog/Verilog
- **Style:** Synthesizable RTL with proper coding guidelines
- **FSM Implementation:** Enum-based state encoding with separate combinational and sequential blocks
- **Testbench:** SystemVerilog class-based testbench with random stimulus generation
- **Verification:** Functional simulation using Cadence Xcelium

### Synthesis (Part 2)
- **Tool:** Cadence Genus Synthesis Solution 25.11
- **Technology Libraries:** 
  - TSMC65LP (standard cells)
  - ARM65LP_SC (standard cell library)
  - ARM65LP_SRAM (memory macros)
- **Constraints:** SDC-based timing constraints with clock uncertainty
- **Optimization:** High effort for generic and optimization phases
- **Physical Awareness:** LEF-based physical synthesis

### Gate-Level Verification (Part 3)
- **Zero-Delay Simulation:** Initial GLV without timing
- **SDF Back-Annotation:** Maximum delay annotation for timing-accurate simulation
- **Power Analysis:** VCD-based activity file generation and analysis

## Performance Metrics

### Timing Results
- **Clock Period:** 2.0 ns (500 MHz target frequency)
- **Operating Frequency:** 333.324 MHz (achieved)
- **Timing Violations:** 0 (all paths meet timing)
- **Worst Negative Slack (WNS):** 0.0 ps
- **Total Negative Slack (TNS):** 0.0 ps

### Area Results
- **Cell Area:** 5,850.36 µm²
- **Net Area:** 2,162.79 µm²
- **Total Area:** 8,013.15 µm²
- **Leaf Instances:** 1,412 cells
- **Sequential Cells:** 261 (18.5%)
- **Combinational Cells:** 1,151 (81.5%)

### Power Results
- **Total Power:** 358.2 µW
- **Analysis Method:** Static power analysis with VCD activity
- **Operating Conditions:** SS (Slow-Slow) corner, 0.90V, 125°C

### Clock Gating Optimization
- **Gated Flip-flops:** 207 out of 255 (81.18%)
- **Clock Gating Instances:** 6
- **Average Toggle Saving:** 52.96% (RC clock gating)
- **Power Reduction:** Significant reduction in dynamic power through clock gating

## Design Optimizations

1. **Clock Gating**
   - Automatic insertion by synthesis tool
   - Minimum 8 flip-flops per gating group
   - Latch-based clock gating style
   - Resulted in 81% of flip-flops being gated

2. **Timing Closure**
   - Careful constraint definition (SDC)
   - Clock uncertainty: 125 ps
   - Input/output delays: 660 ps
   - Achieved zero timing violations

3. **Area Optimization**
   - Technology mapping to optimal cell sizes
   - Multi-bit flip-flop inference where applicable
   - Efficient combinational logic synthesis

4. **Power Optimization**
   - Clock gating for idle state power reduction
   - Low-power cell selection (LVT library)
   - Activity-based power analysis

## Tools and Technologies

### EDA Tools
- **RTL Simulation:** Cadence Xcelium (irun/xrun)
- **Synthesis:** Cadence Genus Synthesis Solution 25.11
- **Power Analysis:** Cadence Voltus
- **Verification:** SystemVerilog testbenches

### Technology
- **Process:** TSMC 65nm Low Power (TSMC65LP)
- **Standard Cells:** ARM 65LP Standard Cell Library
- **Operating Conditions:** SS corner, 0.90V, 125°C
- **Physical Data:** LEF files for physical synthesis

## Verification Strategy

### RTL Verification
- Functional testbench with random stimulus
- Edge case testing (single element, timeout scenarios)
- Self-checking testbench with automatic result comparison
- Coverage-driven verification approach

### Gate-Level Verification
- Zero-delay GLV for functional verification
- SDF back-annotated simulation for timing verification
- Comparison between RTL and gate-level results
- Timing violation detection and analysis

### Power Verification
- VCD file generation from gate-level simulation
- Activity file creation with proper time windows
- Static and dynamic power analysis
- Power hotspot identification

## Project Structure

```
hw3-315212795/
├── src/
│   ├── rtl/              # RTL source files
│   │   ├── average.v     # Top-level module
│   │   ├── sum.v         # Accumulator module
│   │   ├── div.sv        # Division unit
│   │   └── div_wrapper.sv
│   └── tb/               # Testbenches
│       ├── average_tb.sv # Main testbench
│       └── glv_tb.sv     # Gate-level testbench
├── scripts/              # Synthesis and simulation scripts
│   ├── genus.tcl        # Synthesis script
│   ├── voltus.post_synth.tcl  # Power analysis
│   └── simulation.tcl
├── inputs/               # Design constraints and definitions
│   ├── average.defines   # Design parameters
│   └── average.sdc       # Timing constraints
├── reports/              # Analysis reports
│   ├── synthesis/       # Synthesis reports
│   └── my_summary.txt    # Summary metrics
└── export/               # Synthesized netlists and SDF
    ├── post_synth/       # Post-synthesis files
    └── simulation/       # Simulation waveforms
```

## Key Achievements

✅ **Zero Timing Violations** - All timing paths meet constraints  
✅ **Power Optimized** - 81% of flip-flops clock-gated  
✅ **Full Design Flow** - RTL to gate-level with power analysis  
✅ **Industry Tools** - Professional Cadence EDA toolchain  
✅ **Production-Ready** - Synthesizable, verified, and documented  

## Technical Skills Demonstrated

- **RTL Design:** SystemVerilog/Verilog coding, FSM design, modular design
- **Synthesis:** Constraint definition, optimization strategies, timing closure
- **Verification:** Testbench development, gate-level simulation, SDF annotation
- **Power Analysis:** Activity file generation, power estimation, optimization
- **Tool Proficiency:** Cadence Genus, Voltus, Xcelium
- **Methodology:** Industry-standard design flow and best practices

## Future Enhancements

Potential improvements for future iterations:
- Pipelined division unit for higher throughput
- Configurable timeout period
- Support for signed arithmetic
- Additional power modes (sleep, retention)
- Scan chain insertion for testability

---

**Author:** Yedidya Krimolovski  
**Student ID:** 315212795  
**Course:** 83-612 Digital VLSI Design  
**Year:** 2025-26

