#!/bin/bash
# Automated Portfolio Upload Script
# Author: Curtis Charles Farrar
# Purpose: Streamline portfolio updates to GitHub

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Curtis Farrar Portfolio Upload Automation ===${NC}\n"

# Configuration
REPO_NAME="curtis-farrar-portfolio"
BRANCH="main"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    exit 1
fi

# Function to check git status
check_git_status() {
    if git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}No changes to commit${NC}"
        return 1
    else
        echo -e "${GREEN}Changes detected${NC}"
        return 0
    fi
}

# Function to commit and push
commit_and_push() {
    local commit_message="$1"
    
    echo -e "${GREEN}Adding files...${NC}"
    git add -A
    
    echo -e "${GREEN}Committing changes...${NC}"
    git commit -m "$commit_message" || {
        echo -e "${RED}Commit failed${NC}"
        return 1
    }
    
    echo -e "${GREEN}Pushing to $BRANCH...${NC}"
    git push origin "$BRANCH" || {
        echo -e "${RED}Push failed${NC}"
        return 1
    }
    
    echo -e "${GREEN}✓ Successfully uploaded to GitHub${NC}"
    return 0
}

# Main execution
if [ $# -eq 0 ]; then
    COMMIT_MSG="Update portfolio: $(date +%Y-%m-%d)"
else
    COMMIT_MSG="$1"
fi

echo -e "Commit message: ${YELLOW}$COMMIT_MSG${NC}\n"

if check_git_status; then
    commit_and_push "$COMMIT_MSG"
    echo -e "\n${GREEN}Portfolio successfully updated!${NC}"
    echo -e "View at: ${YELLOW}https://github.com/POWDER-RANGER/$REPO_NAME${NC}"
else
    echo -e "${YELLOW}No updates needed${NC}"
fi