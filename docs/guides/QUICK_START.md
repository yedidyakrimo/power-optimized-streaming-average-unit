# Quick Start - Upload to GitHub

## Problem with Automated Script

There's an issue with the terminal/shell that prevents automated execution. Please follow these manual steps:

## Manual Steps

### 1. Open PowerShell in the project directory

Navigate to:
```
C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
```

### 2. Run the PowerShell script

```powershell
.\upload_to_github.ps1
```

This will:
- Initialize git repository
- Remove PDFs from tracking
- Add all files
- Create initial commit

### 3. Create GitHub Repository

1. Go to: https://github.com/new
2. Repository name: `power-optimized-streaming-average-unit` (or your choice)
3. Choose Public or Private
4. **DO NOT** check "Initialize with README"
5. Click "Create repository"

### 4. Connect and Push

After creating the repository, GitHub will show you the commands. Run:

```powershell
# Replace YOUR_USERNAME and YOUR_REPO_NAME
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

## Alternative: Manual Commands

If the script doesn't work, run these commands manually:

```powershell
# Navigate to project
cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795

# Initialize git
git init

# Remove PDFs
git rm --cached docs/*.pdf

# Add files
git add .

# Commit
git commit -m "Power-Optimized Streaming Average Unit - VLSI Design Project"

# Create repo on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

## Troubleshooting

### "Git is not recognized"
- Install Git from: https://git-scm.com/
- Restart PowerShell after installation

### "Permission denied" or authentication error
- You may need to authenticate with GitHub
- Use GitHub CLI or Personal Access Token
- See: https://docs.github.com/en/authentication

### "Repository not found"
- Make sure you created the repository on GitHub first
- Check the repository name matches

---

**Note:** The automated script had issues due to shell encoding problems. The manual steps above should work perfectly.


