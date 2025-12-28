@echo off
chcp 65001 >nul
echo ========================================
echo Git Repository Setup Script
echo ========================================
echo.

cd /d "%~dp0"

echo Checking Git installation...
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Git is not installed
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

git --version
echo.

echo Git Configuration:
git config --global user.name
git config --global user.email
echo.

echo Current directory: %CD%
echo.

if exist ".git" (
    echo Git repository already exists
) else (
    echo Initializing Git repository...
    git init
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Failed to initialize repository
        pause
        exit /b 1
    )
)

echo.
echo Removing PDFs from tracking...
git rm --cached docs\*.pdf 2>nul

echo.
echo Adding files to staging area...
git add .

echo.
echo Files staged for commit:
git status --short

echo.
echo Creating commit...
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

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Repository is ready for GitHub
    echo ========================================
    echo.
    echo Next steps:
    echo 1. Create repository on GitHub: https://github.com/new
    echo 2. Then run:
    echo    git remote add origin https://github.com/yedidyakrimo/YOUR_REPO_NAME.git
    echo    git branch -M main
    echo    git push -u origin main
) else (
    echo.
    echo Note: If you see "nothing to commit", files are already committed
)

echo.
pause


