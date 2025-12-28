# How to Run the Setup Script

## The Problem

There's a shell encoding issue preventing automated execution. I've created a batch script that should work.

## Solution: Run the Batch Script

### Option 1: Double-Click (Easiest)

1. Navigate to: `C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795`
2. **Double-click** `RUN_ME.bat`
3. The script will:
   - Check Git installation
   - Show your Git configuration
   - Initialize repository
   - Remove PDFs
   - Add all files
   - Create commit

### Option 2: Command Prompt

1. Open **Command Prompt** (Win+R, type `cmd`, Enter)
2. Navigate to the project:
   ```cmd
   cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
   ```
3. Run the script:
   ```cmd
   RUN_ME.bat
   ```

### Option 3: PowerShell

1. Open **PowerShell**
2. Navigate to the project:
   ```powershell
   cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
   ```
3. Run the script:
   ```powershell
   .\RUN_ME.bat
   ```

## After the Script Completes

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

## Your Git Info

- **Username:** yedidyakrimo
- **Email:** santoriny4132@gmail.com

The script will use these automatically.

---

**Just double-click `RUN_ME.bat` to get started!**


