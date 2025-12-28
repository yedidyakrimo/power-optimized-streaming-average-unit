# GitHub Upload Guide - Legal and Best Practices

## ✅ Safe to Upload

### Your Own Code
- ✅ `src/rtl/average.v` - Your RTL implementation
- ✅ `src/rtl/sum.v` - Your accumulator module
- ✅ `src/tb/average_tb.sv` - Your testbench
- ✅ `src/tb/glv_tb.sv` - Your gate-level testbench
- ✅ `scripts/genus.tcl` - Your synthesis script (modified from template)
- ✅ `scripts/voltus.post_synth.tcl` - Your power analysis script
- ✅ `inputs/average.defines` - Your design configuration
- ✅ `inputs/average.sdc` - Your timing constraints
- ✅ `reports/` - Your synthesis and analysis reports
- ✅ `export/post_synth/average.v` - Your synthesized netlist
- ✅ `export/post_synth/average.sdf` - Your SDF file
- ✅ All documentation files you created (README, PROJECT_DESCRIPTION, etc.)

### Provided/Example Files (Generally OK)
- ✅ `src/rtl/div.sv` - Provided divider (has "DO NOT TOUCH" but it's part of the project)
- ✅ `src/rtl/div_wrapper.sv` - Wrapper you created
- ✅ `scripts/procedures.tcl` - Course helper procedures (ENICS)
- ✅ `libraries/*.tcl` - Library path definitions (not the actual libraries)
- ✅ `inputs/libraries.*.tcl` - Library configuration files

## ⚠️ Questionable - Review Before Upload

### Example/Demo Files
- ✅ `src/rtl/sm.v` and `src/tb/sm_tb.v` - **DELETED** (example files by Nir Sever have been removed)
- ⚠️ `src/tb/sum_tb.sv` - Check if this is your work or provided template

## ❌ DO NOT Upload

### Copyrighted Materials
- ❌ `docs/*.pdf` - Course PDFs (copyright of university/instructor)
- ❌ Actual library files (`.lib`, `.db`, `.lef`, `.gds`) - Proprietary to ARM/TSMC
- ❌ Large simulation files (`.vcd`, `.fsdb`) - Can be regenerated

### Large/Generated Files
- ❌ `export/simulation/*.vcd` - Large waveform files
- ❌ `export/post_synth/*.vcd` - Large waveform files
- ❌ Binary database files

## 📋 Pre-Upload Checklist

Before uploading to GitHub:

1. **Remove Course PDFs**
   ```bash
   # Remove or don't commit docs/*.pdf
   ```

2. **Remove Large Files**
   - Check `.gitignore` is in place
   - Remove any `.vcd` files from tracking
   - Remove any `.db` library files

3. **Example Files Status**
   - ✅ `src/rtl/sm.v` and `src/tb/sm_tb.v` have been deleted (example files by Nir Sever)
   - For `div.sv`: Note that it was provided by the course
   - For `procedures.tcl`: Note it's a course helper script

4. **Add License**
   - Consider adding a LICENSE file
   - For academic projects, MIT or Apache 2.0 are common choices
   - Or add: "Academic project - not for commercial use"

5. **Review Scripts**
   - Make sure no hardcoded paths to proprietary tools
   - Remove any internal server paths
   - Remove any credentials or sensitive information

## 🔒 Legal Considerations

### What's Generally Safe:
- **Your own code** - You own the copyright
- **Course templates** - Usually OK for academic portfolios
- **Configuration files** - Path definitions, not actual libraries
- **Synthesis results** - Your work product

### What's Problematic:
- **Course PDFs** - Copyright of university/instructor
- **Proprietary libraries** - ARM, TSMC libraries are licensed
- **Tool licenses** - Don't share license files or keys

### Best Practice:
Add a disclaimer in your README:
```markdown
## Disclaimer
This is an academic project. Some files (div.sv, procedures.tcl) were provided 
as part of the course materials. Library definition files are included for 
reference, but actual proprietary library files are not included.
```

## 📝 Recommended Repository Structure

```
your-repo/
├── src/
│   ├── rtl/
│   │   ├── average.v          ✅ Your code
│   │   ├── sum.v              ✅ Your code
│   │   ├── div.sv             ✅ Provided (note in README)
│   │   └── div_wrapper.sv     ✅ Your wrapper
│   └── tb/
│       ├── average_tb.sv      ✅ Your testbench
│       └── glv_tb.sv          ✅ Your GLV testbench
├── scripts/
│   ├── genus.tcl              ✅ Your synthesis script
│   └── procedures.tcl         ⚠️ Course helper (OK to include)
├── inputs/
│   └── average.*              ✅ Your configuration
├── reports/                   ✅ Your results
├── export/
│   └── post_synth/
│       ├── average.v         ✅ Your netlist
│       └── average.sdf        ✅ Your SDF
├── README.md                  ✅ Your documentation
└── .gitignore                 ✅ Excludes problematic files
```

## 🎯 Final Recommendation

**YES, you can upload this project to GitHub**, but:

1. ✅ Use the provided `.gitignore`
2. ✅ Remove `docs/*.pdf` files
3. ✅ Add attribution notes for provided files
4. ✅ Add a LICENSE file (MIT recommended for academic projects)
5. ✅ Add a disclaimer about provided files
6. ✅ Make the repository **private** if you're concerned, or **public** if you want to showcase your work

## 📄 Sample LICENSE (MIT - Recommended)

You can add this to a `LICENSE` file:

```
MIT License

Copyright (c) 2025 Yedidya Krimolovski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Note: Some files (div.sv, procedures.tcl) were provided as part of course 
materials. Library definition files are for reference only.
```

---

**Summary:** Your project is safe to upload with proper `.gitignore` and attribution. The main concern is course PDFs, which should be excluded.


