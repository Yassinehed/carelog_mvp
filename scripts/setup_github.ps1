<#
PowerShell script: setup_github.ps1
Creates a GitHub repo (private) with `gh`, initializes git (if necessary) and pushes the code.
Usage:
  .\setup_github.ps1 -GithubUser "youruser" -RepoName "carelog_mvp" -Visibility private

Requirements:
- Git installed and configured (git config user.name/email)
- GitHub CLI (`gh`) authenticated (run `gh auth login` first)
#>
param(
  [Parameter(Mandatory=$true)] [string] $GithubUser,
  [Parameter(Mandatory=$true)] [string] $RepoName,
  [ValidateSet('private','public')] [string] $Visibility = 'private'
)

Write-Host "Starting GitHub repo setup for $GithubUser/$RepoName (visibility=$Visibility)" -ForegroundColor Cyan

# Ensure Git is initialized
if (-not (Test-Path .git)) {
  Write-Host "Initializing git repository..."
  git init
  git add .
  git commit -m "Initial commit - CareLog MVP"
  git branch -M main
} else {
  Write-Host "Git repository already initialized."
}

# Create GitHub repo using gh
Write-Host "Creating GitHub repository via gh..."
$createCmd = "gh repo create $GithubUser/$RepoName --$Visibility --source=. --remote=origin --push"
Invoke-Expression $createCmd

Write-Host "Repository created and pushed. Configure branch protections and secrets via GitHub UI or gh." -ForegroundColor Green
Write-Host "Next: run scripts\set_github_secrets.ps1 to add secrets (service account, FIREBASE_TOKEN, reCAPTCHA keys)." -ForegroundColor Yellow
