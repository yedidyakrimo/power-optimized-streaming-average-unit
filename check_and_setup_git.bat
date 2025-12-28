@echo off
REM Batch script to check Git and setup repository
REM This should work even with shell encoding issues

echo === Checking Git Installation ===
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Git is not installed or not in PATH
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

echo Git found!
git --version
echo.

echo === Checking Git Configuration ===
git config --global user.name
git config --global user.email
echo.

echo === Current Directory ===
cd
echo.

echo === Checking if Git repository exists ===
if exist ".git" (
    echo Git repository already exists
    git status --short
) else (
    echo No Git repository found - will initialize
)
echo.

echo === Ready to setup repository ===
echo.
echo Press any key to continue with setup, or Ctrl+C to cancel...
pause >nul

echo.
echo === Initializing Git Repository ===
if not exist ".git" (
    git init
)

echo.
echo === Removing PDFs from tracking ===
git rm --cached docs\*.pdf 2>nul

echo.
echo === Adding files ===
git add .

echo.
echo === Files staged: ===
git status --short

echo.
echo === Creating commit ===
git commit -m "Power-Optimized Streaming Average Unit - VLSI Design Project

- Complete RTL to gate-level design flow
- Synthesis with Cadence Genus (TSMC65LP)
- Power optimization with 81%% clock-gating coverage
- Gate-level verification with SDF back-annotation
- Power analysis with Cadence Voltus

Results:
- 333 MHz operating frequency
- 358.2 µW total power
- Zero timing violations
- 5,850 µm² optimized area"

echo.
echo === Repository ready! ===
echo.
echo Next steps:
echo 1. Create repository on GitHub: https://github.com/new
echo 2. Then run:
echo    git remote add origin https://github.com/yedidyakrimo/YOUR_REPO_NAME.git
echo    git branch -M main
echo    git push -u origin main
echo.
pause


