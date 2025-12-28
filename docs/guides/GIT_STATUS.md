# Git Status Check

## Git Configuration Found ✅

Your Git is properly configured:

- **Username:** yedidyakrimo
- **Email:** santoriny4132@gmail.com
- **Config file:** `C:\Users\yedidya\.gitconfig`

## Shell Issue

There's a shell encoding problem preventing direct command execution. 

## Solution: Use Batch Script

I've created `check_and_setup_git.bat` that should work despite the shell issue.

### To use:

1. **Open Command Prompt** (not PowerShell) in the project directory:
   ```
   cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
   ```

2. **Run the batch script:**
   ```
   check_and_setup_git.bat
   ```

This will:
- ✅ Check Git installation
- ✅ Show your Git configuration
- ✅ Initialize repository (if needed)
- ✅ Remove PDFs from tracking
- ✅ Add all files
- ✅ Create initial commit

## After Running the Script

1. **Create GitHub repository:**
   - Go to: https://github.com/new
   - Repository name: `power-optimized-streaming-average-unit`
   - Choose Public or Private
   - **DO NOT** check "Initialize with README"
   - Click "Create repository"

2. **Connect and push:**
   ```cmd
   git remote add origin https://github.com/yedidyakrimo/power-optimized-streaming-average-unit.git
   git branch -M main
   git push -u origin main
   ```

## Alternative: Manual Commands

If the batch script doesn't work, run these in Command Prompt:

```cmd
cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
git init
git rm --cached docs\*.pdf
git add .
git commit -m "Power-Optimized Streaming Average Unit - VLSI Design Project"
```

Then create the GitHub repository and push as shown above.


