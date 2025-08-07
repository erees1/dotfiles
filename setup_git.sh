#!/usr/bin/env bash
# Setup git configuration with user details

set -euo pipefail

cd "$(dirname "$0")"

echo "Setting up git configuration..."

# Check if gitconfig.local already exists
if [ -f git/gitconfig.local ]; then
    echo "git/gitconfig.local already exists, skipping setup"
    exit 0
fi

# Since we're Mac-only, always use osxkeychain
git_credential='osxkeychain'

# Get user details
echo ""
read -p "Enter your GitHub author name: " git_authorname
read -p "Enter your GitHub author email: " git_authoremail

# Create gitconfig.local from template
sed -e "s/AUTHORNAME/$git_authorname/g" \
    -e "s/AUTHOREMAIL/$git_authoremail/g" \
    -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
    git/gitconfig.local.example > git/gitconfig.local

echo "✓ Git configuration complete"
