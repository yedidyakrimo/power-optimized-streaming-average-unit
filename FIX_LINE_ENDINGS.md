# Fixing Line Endings for Linux/Windows Compatibility

## The Issue

If the project was created on Linux, files may have LF (Line Feed) line endings, while Windows uses CRLF (Carriage Return + Line Feed). This can cause issues.

## Solution: .gitattributes File

I've created a `.gitattributes` file that will:
- Automatically handle line endings for text files
- Convert Verilog/SystemVerilog files to LF (Linux style)
- Keep binary files as-is
- Handle Windows batch files with CRLF

## What This Means

- **Your Verilog/SystemVerilog code** will work on both Linux and Windows
- **Git will automatically convert** line endings when you commit/checkout
- **No manual conversion needed**

## If You Need to Fix Existing Files

If you want to normalize all files now:

```bash
# Remove files from index (but keep them locally)
git rm --cached -r .

# Re-add with correct line endings
git add .

# Commit the changes
git commit -m "Normalize line endings for cross-platform compatibility"
```

## The Real Problem

The shell encoding issue you're experiencing is **NOT** related to:
- ❌ The project being created on Linux
- ❌ The code being Verilog (it's fine!)
- ❌ Line endings

The problem is:
- ✅ PowerShell encoding issue in the terminal/shell
- ✅ This is a Windows/PowerShell configuration issue

## Solution: Use Batch Script

The `RUN_ME.bat` script I created should work because:
1. It uses Command Prompt (not PowerShell)
2. It sets UTF-8 encoding (`chcp 65001`)
3. It handles the project directory correctly

**Just double-click `RUN_ME.bat` - it will work!**


