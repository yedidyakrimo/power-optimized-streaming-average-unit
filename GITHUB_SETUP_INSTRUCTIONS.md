# GitHub Upload Instructions

## Step 1: Prepare the Project

Open PowerShell or Command Prompt in the project directory:

```powershell
cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
```

## Step 2: Initialize Git Repository

```powershell
# Initialize repository (if not already initialized)
git init

# Remove PDFs from tracking (if they are already tracked)
git rm --cached docs/*.pdf
```

## Step 3: Add Files

```powershell
# Add all files (respecting .gitignore)
git add .

# Check what was added
git status
```

## Step 4: Create Initial Commit

```powershell
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
```

## Step 5: Create Repository on GitHub

1. Go to https://github.com/new
2. Choose a repository name (e.g., `power-optimized-streaming-average-unit`)
3. **Do NOT check** "Initialize with README" (we already have one)
4. Choose Public or Private (recommended: Private for academic projects)
5. Click "Create repository"

## Step 6: Connect to GitHub

After creating the repository, GitHub will show you instructions. Run the following commands:

### If using HTTPS:
```powershell
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

### If using SSH:
```powershell
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

**Replace:**
- `YOUR_USERNAME` - Your GitHub username
- `YOUR_REPO_NAME` - The repository name you created

## Step 7: Verify

Go to `https://github.com/YOUR_USERNAME/YOUR_REPO_NAME` and verify everything uploaded successfully!

---

## Troubleshooting

### If you get authentication error:
```powershell
# Check if you're logged in
git config --global user.name
git config --global user.email

# If not, set:
git config --global user.name "Yedidya Krimolovski"
git config --global user.email "your-email@example.com"
```

### If you get push error:
- Make sure you created the repository on GitHub
- Verify the remote name is correct
- Try: `git push -u origin main --force` (careful - this overwrites what's on GitHub)

### If PDFs still appear:
```powershell
# Remove them manually
git rm --cached docs/*.pdf
git commit -m "Remove PDFs from repository"
git push
```

---

## Files Already Prepared

✅ `.gitignore` - Prevents uploading problematic files  
✅ `LICENSE` - MIT License  
✅ `README.md` - Detailed documentation  
✅ `GITHUB_UPLOAD_GUIDE.md` - Detailed upload guide  

---

## Tips

1. **Recommended Repository Name:** `power-optimized-streaming-average-unit` or `vlsi-average-unit`
2. **Recommended Description:** "Power-optimized streaming average computation unit - Complete VLSI design flow (RTL→Synthesis→GLV→Power)"
3. **Recommended Topics:** `vlsi`, `digital-design`, `cadence`, `synthesis`, `power-optimization`, `systemverilog`

---

**Good luck! 🚀**
