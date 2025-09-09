CI & Secrets: Generate and add required secrets for GitHub Actions

This document explains how to generate and add the main secrets used by the CI and Firebase integration.

Required secrets
- FIREBASE_TOKEN: For CI deployments with Firebase CLI.
- FIREBASE_SERVICE_ACCOUNT: Service account JSON for server-side operations (base64-encoded).
- RECAPTCHA_SITE_KEY: reCAPTCHA v3 site key for Firebase App Check (web client).
- RECAPTCHA_SECRET: reCAPTCHA secret (if used server-side).

Generate a FIREBASE_TOKEN
1. Install Firebase CLI: https://firebase.google.com/docs/cli
2. Login interactively (local dev machine):

```powershell
firebase login
```

3. Generate a CI token:

```powershell
firebase login:ci
# copy the printed token
```

4. Save token as GitHub secret using `gh` or GitHub UI:

```powershell
gh secret set FIREBASE_TOKEN --body "<PASTE_TOKEN_HERE>"
```

Service account JSON (preferred for server-side operations)
1. In Google Cloud Console (IAM & Admin → Service Accounts) create a service account with the required roles for Firebase (e.g., Firebase Admin, Firestore Admin, Storage Admin) and generate a JSON key.
2. On your local machine, base64-encode the JSON and add as secret (the provided script does it for you):

```powershell
# Using the helper script
.\scripts\set_github_secrets.ps1 -ServiceAccountPath '.\\keys\\service-account.json'
```

Or manually:

```powershell
$bytes = [System.IO.File]::ReadAllBytes('path\\to\\service-account.json')
$b64 = [Convert]::ToBase64String($bytes)
gh secret set FIREBASE_SERVICE_ACCOUNT --body $b64
```

reCAPTCHA site key (for Firebase App Check on web)
- Register your site in Google reCAPTCHA v3 and add the site key in Firebase App Check console.
- Save the site key as GitHub secret:

```powershell
gh secret set RECAPTCHA_SITE_KEY --body "<SITE_KEY>"
```

Notes and best practices
- Prefer service account via base64 secret rather than storing JSON file in the repo.
- Limit roles on the service account to the minimum required (principle of least privilege).
- Rotate secrets regularly and revoke old keys when compromised.
- Do not store secrets in plain text or in code.

After adding secrets
- Trigger a test workflow by opening a PR or pushing a branch to verify CI can access secrets and that build/deploy steps that require secrets only run on protected branches or via manual workflows.
