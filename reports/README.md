# Reports Directory

This directory contains all generated reports from synthesis, simulation, and power analysis.

## Directory Structure

### synthesis/
Synthesis reports organized by stage:

#### post_elaboration/
- `check_design_post_elab.rpt` - Design rule checks after elaboration
- `check_timing_post_elab.rpt` - Timing checks after elaboration
- `in2reg.timing.rpt` - Input to register timing paths
- `reg2reg.timing.rpt` - Register to register timing paths
- `reg2out.timing.rpt` - Register to output timing paths
- `in2out.timing.rpt` - Input to output timing paths

#### post_opt/
- `report_qor.rpt` - Quality of Results summary
- `report_area.rpt` - Area report
- `report_gates.rpt` - Gate count report
- `report_clock_gating.rpt` - Clock gating analysis
- `report_design_rules.rpt` - Design rule violations
- `report_dp.rpt` - Datapath report
- `report_hierarchy.rpt` - Design hierarchy

#### technology_mapping/
- Timing reports after technology mapping

#### set_dont_use/
- Timing reports with don't-use cell constraints

#### post_syn_opt/
- Final post-synthesis optimization timing reports

### simulation/
- `sdf_statistics.rpt` - SDF back-annotation statistics

## Output Files

In addition to reports, this directory contains:
- `average_output.txt` - RTL simulation output
- `avg_output-part1.txt` - Partial simulation results
- `my_summary.txt` - Synthesis summary
- `my_summary_power.txt` - Power analysis summary

## Usage

These reports are automatically generated when running:
- Synthesis: `scripts/genus.tcl`
- Simulation: `scripts/simulation.tcl`
- Power analysis: `scripts/voltus.post_synth.tcl`

Refer to [TECHNICAL_METRICS.md](../TECHNICAL_METRICS.md) for a summary of key metrics from these reports.
