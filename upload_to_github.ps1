# PowerShell script to upload project to GitHub
# Run this script from the project root directory

Write-Host "=== Uploading Power-Optimized Streaming Average Unit to GitHub ===" -ForegroundColor Green
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version 2>&1
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/" -ForegroundColor Yellow
    exit 1
}

# Check if we're in the right directory
if (-not (Test-Path "src/rtl/average.v")) {
    Write-Host "ERROR: Please run this script from the project root directory" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    exit 1
}

Write-Host "Current directory: $(Get-Location)" -ForegroundColor Cyan
Write-Host ""

# Initialize git repository if not already initialized
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to initialize git repository" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Git repository already initialized" -ForegroundColor Green
}

# Remove PDFs from tracking if they exist
if (Test-Path "docs") {
    Write-Host "Removing PDFs from tracking (copyright protected)..." -ForegroundColor Yellow
    git rm --cached docs/*.pdf 2>$null
}

# Add all files (respecting .gitignore)
Write-Host "Adding files to staging area..." -ForegroundColor Yellow
git add .

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to add files" -ForegroundColor Red
    exit 1
}

# Show what will be committed
Write-Host ""
Write-Host "Files staged for commit:" -ForegroundColor Cyan
git status --short

# Create initial commit
Write-Host ""
Write-Host "Creating initial commit..." -ForegroundColor Yellow
git commit -m "Power-Optimized Streaming Average Unit - VLSI Design Project

- Complete RTL to gate-level design flow
- Synthesis with Cadence Genus (TSMC65LP)
- Power optimization with 81% clock-gating coverage
- Gate-level verification with SDF back-annotation
- Power analysis with Cadence Voltus

Results:
- 333 MHz operating frequency
- 358.2 µW total power
- Zero timing violations
- 5,850 µm² optimized area"

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to create commit" -ForegroundColor Red
    Write-Host "Note: If files are already committed, this is OK" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Repository ready for GitHub! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Create a new repository on GitHub:" -ForegroundColor White
Write-Host "   Go to: https://github.com/new" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. After creating the repository, run these commands:" -ForegroundColor White
Write-Host ""
Write-Host "   For HTTPS:" -ForegroundColor Cyan
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow
Write-Host ""
Write-Host "   For SSH:" -ForegroundColor Cyan
Write-Host "   git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow
Write-Host ""
Write-Host "Replace YOUR_USERNAME and YOUR_REPO_NAME with your actual values" -ForegroundColor White
Write-Host ""


