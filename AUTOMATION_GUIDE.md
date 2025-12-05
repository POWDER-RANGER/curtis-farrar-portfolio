# Portfolio Automation Guide

## Overview

This guide explains how to use the automated upload scripts to streamline portfolio updates to GitHub.

---

## Quick Start

### Linux/Mac (Bash)

```bash
# Make script executable
chmod +x scripts/upload_portfolio.sh

# Run with default commit message
./scripts/upload_portfolio.sh

# Run with custom commit message
./scripts/upload_portfolio.sh "Added new project documentation"
```

### Windows (PowerShell)

```powershell
# Run with default commit message
.\scripts\upload_portfolio.ps1

# Run with custom commit message
.\scripts\upload_portfolio.ps1 "Added new project documentation"
```

---

## Features

### Automation Scripts

1. **upload_portfolio.sh** (Linux/Mac)
   - Automatic change detection
   - Smart commit and push
   - Colored console output
   - Error handling and reporting

2. **upload_portfolio.ps1** (Windows)
   - Identical functionality to bash version
   - Native PowerShell integration
   - Windows-optimized error handling

### GitHub Actions Workflow

**Automatic Weekly Updates**
- Runs every Sunday at midnight (UTC)
- Updates portfolio statistics
- Commits changes automatically
- Can be triggered manually

---

## Usage Examples

### Scenario 1: Quick Portfolio Update

```bash
# Edit your files (README.md, projects, etc.)
vim README.md

# Upload changes
./scripts/upload_portfolio.sh
```

### Scenario 2: Adding New Project

```bash
# Create new project documentation
vim PROJECTS_DETAILED.md

# Upload with descriptive message
./scripts/upload_portfolio.sh "Added CIVWATCH project details"
```

### Scenario 3: Bulk Updates

```bash
# Make multiple changes
vim README.md
vim TECHNICAL_RESUME.md
vim PROJECTS_DETAILED.md

# Single upload command
./scripts/upload_portfolio.sh "Portfolio refresh: Updated all documentation"
```

---

## Manual GitHub Upload (Alternative)

If you prefer manual control:

```bash
# Check status
git status

# Stage changes
git add -A

# Commit
git commit -m "Your commit message"

# Push
git push origin main
```

---

## Troubleshooting

### Common Issues

**Issue**: "Permission denied" when running bash script
```bash
# Solution: Make script executable
chmod +x scripts/upload_portfolio.sh
```

**Issue**: "Execution policy" error in PowerShell
```powershell
# Solution: Set execution policy (run PowerShell as Admin)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Issue**: "Authentication failed" during push
```bash
# Solution: Configure GitHub credentials
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# For HTTPS: Use personal access token
# Settings → Developer settings → Personal access tokens
```

**Issue**: "No changes to commit"
```bash
# Solution: This means no files were modified
# Edit files first, then run script
```

---

## Advanced Configuration

### Custom Commit Message Templates

Edit the scripts to use custom templates:

```bash
# In upload_portfolio.sh, modify:
COMMIT_MSG="[Portfolio] Your custom prefix: $(date +%Y-%m-%d)"
```

### Auto-Push on File Save (Optional)

For advanced users, integrate with file watchers:

```bash
# Install inotify-tools (Linux)
sudo apt install inotify-tools

# Watch for changes and auto-upload
while inotifywait -e modify README.md; do
    ./scripts/upload_portfolio.sh "Auto-update: README modified"
done
```

---

## GitHub Actions Manual Trigger

1. Go to your repository on GitHub
2. Click "Actions" tab
3. Select "Update Portfolio Stats" workflow
4. Click "Run workflow"
5. Confirm execution

---

## Best Practices

### Commit Messages
- **Good**: "Added OBELISK_CORE technical documentation"
- **Good**: "Updated TECHNICAL_RESUME with new projects"
- **Bad**: "Update"
- **Bad**: "asdfasdf"

### Update Frequency
- **After major project milestones**: Immediately
- **Routine updates**: Weekly or bi-weekly
- **Minor typo fixes**: Batch multiple changes

### File Organization
- Keep related changes together
- Update README when adding new sections
- Maintain consistent formatting
- Test markdown rendering before pushing

---

## Security Notes

### Credential Management
- **Never commit API keys or passwords**
- Use `.gitignore` for sensitive files
- Use environment variables for secrets
- Review changes before pushing

### Sensitive Information
Before uploading, ensure no sensitive data:

```bash
# Check for potential secrets
grep -r "password" .
grep -r "api_key" .
grep -r "token" .
```

---

## Integration with Development Workflow

### VSCode Integration

Add to `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Upload Portfolio",
      "type": "shell",
      "command": "./scripts/upload_portfolio.sh",
      "problemMatcher": []
    }
  ]
}
```

Then: `Ctrl+Shift+B` → "Upload Portfolio"

### Git Aliases

Add to `~/.gitconfig`:

```ini
[alias]
    portfolio-push = !bash scripts/upload_portfolio.sh
```

Then simply run: `git portfolio-push`

---

## Support

For issues or questions:
- Check GitHub repository issues
- Review error messages carefully
- Verify git configuration
- Test with manual git commands first

---

*Last Updated: December 2025*