# Power-Optimized Streaming Average Unit

**Course:** 83-612 – Digital VLSI Design  
**Year:** 2025–26  
**Author:** Yedidya Krimolovski (315212795)  
**Project Type:** Digital VLSI Design - Homework 3

## Overview

This repository contains the full three-part mini-project for Homework 3 of the Digital VLSI Design course.
The assignment guides the student through the **complete front-end digital design flow**, from **RTL design and simulation** to **synthesis, gate-level simulation**, and **power estimation**.

## 🎯 Project Summary

**Project Name:** Power-Optimized Streaming Average Unit  
**Design:** Streaming Average Computation Unit  
**Technology:** TSMC65LP (65nm Low Power)  
**Tools:** Cadence Genus, Voltus, Xcelium

### Key Results

| Metric | Result | Status |
|--------|--------|--------|
| **Operating Frequency** | 333.324 MHz (2ns period) | ✅ |
| **Total Power** | 358.2 µW | ✅ |
| **Area** | 5,850 µm² (cell) | ✅ |
| **Timing Violations** | 0 | ✅ |
| **Clock Gating** | 81.18% of FFs gated | ✅ |

### Design Features

- **3-State FSM** with timeout mechanism (10 cycles)
- **Streaming Data Processing** with variable-length sequences
- **Integrated Modules:** Accumulator (Sum_mod) + Division Unit (divu_int)
- **Power Optimization:** Clock gating with 52.96% toggle saving
- **Full Verification:** RTL → Gate-Level → Power Analysis

📖 **[Detailed Project Description](PROJECT_DESCRIPTION.md)** | 📊 **[Technical Metrics](TECHNICAL_METRICS.md)** | 💼 **[Resume Descriptions](docs/RESUME_DESCRIPTION.md)**

## Instructions

As always the full instructions are under the `docs/` folder and in the course's Discord server. Below is just a brief overview of the tasks to be completed. Go over the documentation for detailed steps, hints, and requirements.

---

## 🧩 Part 1 – RTL Design and Simulation

* **Goal:** Design and verify an `Average` unit that computes the mean of a series of input values.
* **Tasks:**

  * Implement a synthesizable RTL module (`Average.v`) with a given interface.
  * Develop and improve the provided testbench (`average_tb.sv`).
  * Simulate using *Cadence Xcelium* (`irun` / `xrun`) and verify correct functionality.

---

## ⚙️ Part 2 – Synthesis

* **Goal:** Synthesize the RTL design using *Cadence Genus*.
* **Steps:**

  1. Prepare project directories (`src`, `inputs`, `scripts`, `reports`, `exports`).
  2. Set up design constraints (`.sdc`) and parameterized `.defines` file.
  3. Run synthesis via `scripts/genus.tcl`.
  4. Analyze timing, area, and cell usage.

---

## 🔍 Part 3 – Gate-Level Simulation & Power Estimation

* **Goal:** Verify and evaluate the synthesized design at gate level and estimate power.
* **Tasks:**

  1. **Gate-Level Simulation (GLV):**

     * Run zero-delay GLV (`xrun_options.glv`)
     * Perform SDF back-annotated simulation (`xrun_options.backannotation`)
  2. **Power Estimation:**

     * Generate switching activity (`.vcd`)
     * Run *Cadence Voltus* (`voltus.post_synth.tcl`)
     * Review power reports in `export/pwr/power.rpt`

---

## 📊 Performance Metrics

### Synthesis Results
- **Timing:** All paths meet 2.0ns period (zero violations)
- **Area:** 5,850.36 µm² cell area, 8,013.15 µm² total
- **Instances:** 1,412 total (261 sequential, 1,151 combinational)
- **Clock Gating:** 207/255 flip-flops gated (81.18%)

### Power Analysis
- **Total Power:** 358.2 µW @ 333.324 MHz
- **Operating Conditions:** SS corner, 0.90V, 125°C
- **Analysis Method:** Static with VCD activity files

### Verification
- ✅ RTL functional simulation passed
- ✅ Gate-level simulation (zero-delay) passed
- ✅ SDF back-annotated simulation passed
- ✅ Power analysis completed

For detailed metrics, see [TECHNICAL_METRICS.md](TECHNICAL_METRICS.md)

## 📁 Project Structure

```
power-optimized-streaming-average-unit/
├── src/
│   ├── rtl/          # RTL source files (average.v, sum.v, div.sv)
│   └── tb/           # Testbenches (average_tb.sv, glv_tb.sv)
├── scripts/          # Synthesis and simulation scripts
├── inputs/           # Design constraints (SDC, defines)
├── reports/          # Synthesis and analysis reports
│   ├── synthesis/    # Synthesis reports
│   └── simulation/   # Simulation reports
├── output/           # Generated output files
├── workspace/        # Workspace for running scripts
├── docs/             # Documentation
│   ├── RESUME_DESCRIPTION.md     # Resume-ready descriptions
│   └── guides/       # Setup and usage guides
├── tools/            # Utility scripts
│   └── setup/        # Setup and configuration scripts
├── PROJECT_DESCRIPTION.md        # Detailed project documentation
├── TECHNICAL_METRICS.md          # Complete metrics summary
└── README.md         # This file
```

## 🛠️ Tools & Technologies

- **EDA Tools:** Cadence Genus 25.11, Cadence Voltus, Cadence Xcelium
- **Technology:** TSMC65LP, ARM65LP_SC standard cells
- **Languages:** SystemVerilog, Verilog, TCL
- **Methodology:** Industry-standard synthesis flow

## 📚 Additional Documentation

- **[PROJECT_DESCRIPTION.md](PROJECT_DESCRIPTION.md)** - Comprehensive project documentation
- **[TECHNICAL_METRICS.md](TECHNICAL_METRICS.md)** - Detailed performance metrics
- **[RESUME_DESCRIPTION.md](docs/RESUME_DESCRIPTION.md)** - Ready-to-use resume descriptions

### Setup & Usage Guides
- **[Quick Start Guide](docs/guides/QUICK_START.md)** - Getting started with the project
- **[GitHub Setup Instructions](docs/guides/GITHUB_SETUP_INSTRUCTIONS.md)** - Setting up GitHub repository
- **[GitHub Upload Guide](docs/guides/GITHUB_UPLOAD_GUIDE.md)** - Uploading to GitHub
- **[Upload to GitHub](docs/guides/UPLOAD_TO_GITHUB.md)** - Alternative upload instructions

## ⚠️ Disclaimer

This is an academic project. Some files were provided as part of the course materials:
- `src/rtl/div.sv` - Division unit provided by the course (marked "DO NOT TOUCH")
- `scripts/procedures.tcl` - Course helper procedures (ENICS)

Library definition files (`.tcl`) are included for reference, but actual proprietary library files (`.lib`, `.db`, `.lef`) are not included and should not be uploaded.

Course PDFs and example files have been removed from this repository due to copyright.
