<#
PowerShell script: set_github_secrets.ps1
Sets GitHub Actions secrets using `gh secret set`.
Usage examples:
  # Set FIREBASE_TOKEN interactively
  .\set_github_secrets.ps1 -FirebaseToken "<token>"

  # Set service account from file (preferred base64 encoded)
  .\set_github_secrets.ps1 -ServiceAccountPath ".\\keys\\service-account.json"

Requirements:
- GitHub CLI (`gh`) authenticated with a user allowed to set repo secrets.
- The current working directory must be a git repo with remote origin pointing to the repo on GitHub.
#>
param(
  [string] $FirebaseToken,
  [string] $ServiceAccountPath,
  [string] $RecaptchaSiteKey,
  [string] $RecaptchaSecret
)

function Set-SecretIfNotNull([string]$name, [string]$value) {
  if ([string]::IsNullOrWhiteSpace($value)) { return }
  Write-Host "Setting GitHub secret: $name"
  gh secret set $name --body $value
}

if ($FirebaseToken) {
  Set-SecretIfNotNull -name 'FIREBASE_TOKEN' -value $FirebaseToken
} else {
  Write-Host "FIREBASE_TOKEN not provided. You can generate one with 'firebase login:ci' locally and pass it to this script." -ForegroundColor Yellow
}

if ($ServiceAccountPath) {
  if (-not (Test-Path $ServiceAccountPath)) { Write-Error "Service account file not found: $ServiceAccountPath"; exit 1 }
  Write-Host "Encoding service account JSON to base64 and setting FIREBASE_SERVICE_ACCOUNT secret"
  $bytes = [System.IO.File]::ReadAllBytes($ServiceAccountPath)
  $b64 = [Convert]::ToBase64String($bytes)
  Set-SecretIfNotNull -name 'FIREBASE_SERVICE_ACCOUNT' -value $b64
}

if ($RecaptchaSiteKey) { Set-SecretIfNotNull -name 'RECAPTCHA_SITE_KEY' -value $RecaptchaSiteKey }
if ($RecaptchaSecret) { Set-SecretIfNotNull -name 'RECAPTCHA_SECRET' -value $RecaptchaSecret }

Write-Host "All requested secrets have been set (if provided)." -ForegroundColor Green
