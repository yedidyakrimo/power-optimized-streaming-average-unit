# Workspace Directory

This directory serves as the working directory for running simulations and scripts.

## Contents

### Shell Scripts
Convenient wrapper scripts for running different simulations:
- **run_average.csh** - Run average module simulation
- **run_sum.csh** - Run accumulator module simulation
- **run_example.csh** - Run example simulation
- **run_glv.csh** - Run gate-level verification
- **run_pwr.tcsh** - Run power analysis simulation
- **clean_all** - Clean up generated files

## Usage

```bash
cd workspace
./run_average.csh    # Run RTL simulation
./run_glv.csh        # Run gate-level verification
./run_pwr.tcsh       # Run power analysis
./clean_all          # Clean generated files
```

## Notes

- Scripts reference files from `../src/`, `../scripts/`, and `../inputs/`
- Generated waveform dumps and logs may appear in this directory
- Use `clean_all` to remove temporary files before committing
