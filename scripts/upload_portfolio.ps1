# Automated Portfolio Upload Script (PowerShell)
# Author: Curtis Charles Farrar
# Purpose: Streamline portfolio updates to GitHub on Windows

$ErrorActionPreference = "Stop"

Write-Host "=== Curtis Farrar Portfolio Upload Automation ===`n" -ForegroundColor Green

# Configuration
$RepoName = "curtis-farrar-portfolio"
$Branch = "main"

# Check if git is installed
try {
    git --version | Out-Null
} catch {
    Write-Host "Error: git is not installed" -ForegroundColor Red
    exit 1
}

# Function to check git status
function Test-GitChanges {
    $status = git status --porcelain
    if ([string]::IsNullOrEmpty($status)) {
        Write-Host "No changes to commit" -ForegroundColor Yellow
        return $false
    } else {
        Write-Host "Changes detected" -ForegroundColor Green
        return $true
    }
}

# Function to commit and push
function Invoke-CommitAndPush {
    param(
        [string]$CommitMessage
    )
    
    try {
        Write-Host "Adding files..." -ForegroundColor Green
        git add -A
        
        Write-Host "Committing changes..." -ForegroundColor Green
        git commit -m $CommitMessage
        
        Write-Host "Pushing to $Branch..." -ForegroundColor Green
        git push origin $Branch
        
        Write-Host "✓ Successfully uploaded to GitHub" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Main execution
if ($args.Count -eq 0) {
    $CommitMsg = "Update portfolio: $(Get-Date -Format 'yyyy-MM-dd')"
} else {
    $CommitMsg = $args[0]
}

Write-Host "Commit message: $CommitMsg`n" -ForegroundColor Yellow

if (Test-GitChanges) {
    if (Invoke-CommitAndPush -CommitMessage $CommitMsg) {
        Write-Host "`nPortfolio successfully updated!" -ForegroundColor Green
        Write-Host "View at: https://github.com/POWDER-RANGER/$RepoName" -ForegroundColor Yellow
    }
} else {
    Write-Host "No updates needed" -ForegroundColor Yellow
}