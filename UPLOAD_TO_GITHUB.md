# How to Upload to GitHub via Website

Since automated upload has shell issues, here's the simple manual way:

## Step 1: Delete Copyright Files

Before uploading, delete these files manually:
- `docs/HW 3 - Part 1 - 2025-26.pdf`
- `docs/HW 3 - Part 2 - 2025-26.pdf`
- `docs/HW 3 - Part 3 - 2025-26.pdf`
- `src/rtl/sm.v` (example file)
- `src/tb/sm_tb.v` (example file)

## Step 2: Create Repository on GitHub

1. Go to: https://github.com/new
2. Repository name: `power-optimized-streaming-average-unit`
3. Description: "Power-optimized streaming average computation unit - Complete VLSI design flow (RTL→Synthesis→GLV→Power)"
4. Choose **Public** or **Private**
5. **DO NOT** check "Initialize with README"
6. Click **"Create repository"**

## Step 3: Upload Files via GitHub Website

After creating the repository, GitHub will show you options. Choose:

### Option A: Uploading an existing file (Recommended)

1. On the repository page, click **"uploading an existing file"**
2. Drag and drop your entire project folder OR
3. Click "choose your files" and select all files from:
   `C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795`
4. Scroll down and click **"Commit changes"**

### Option B: Using GitHub Desktop

1. Download GitHub Desktop: https://desktop.github.com/
2. Install and sign in with your GitHub account
3. Click "Add" → "Add Existing Repository"
4. Select: `C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795`
5. Click "Publish repository"
6. Choose the repository you created in Step 2

### Option C: Command Line (if you fix the shell issue)

If you can run commands in a new terminal:

```cmd
cd C:\Users\yedidya\Downloads\hw3-315212795\hw3-315212795
git init
git add .
git commit -m "Power-Optimized Streaming Average Unit - VLSI Design Project"
git branch -M main
git remote add origin https://github.com/yedidyakrimo/power-optimized-streaming-average-unit.git
git push -u origin main
```

## Important Notes

- The `.gitignore` file will prevent PDFs and large files from being uploaded
- Make sure you deleted the PDFs before uploading
- Your username is: **yedidyakrimo**
- Replace `power-optimized-streaming-average-unit` with your actual repository name

## What Will Be Uploaded

✅ All your RTL code
✅ Testbenches
✅ Synthesis scripts
✅ Reports
✅ Documentation
✅ License file

The `.gitignore` ensures problematic files won't be uploaded even if you forget to delete them.

---

**The easiest way: Use Option A (drag and drop on GitHub website)!**

