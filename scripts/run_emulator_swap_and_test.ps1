<#
Temporary wrapper to run Firebase emulators with a minimal firebase.json.
It will:
 - backup firebase.json -> firebase.json.bak
 - write a minimal firebase.json containing only 'emulators'
 - run 'firebase emulators:exec' to run the seeder and the integration test
 - restore the original firebase.json

Usage: .\scripts\run_emulator_swap_and_test.ps1
#>

try {
  $repoRoot = Resolve-Path .
  $orig = Join-Path $repoRoot 'firebase.json'
  $backup = Join-Path $repoRoot 'firebase.json.bak'

  if (-Not (Test-Path $orig)) {
    Write-Host "Original firebase.json not found at $orig" -ForegroundColor Red
    exit 1
  }

  Write-Host "Backing up firebase.json to firebase.json.bak"
  Copy-Item -Path $orig -Destination $backup -Force

  $minimal = @'
{
  "emulators": {
    "auth": { "port": 9099 },
    "functions": { "port": 5001 },
    "firestore": { "port": 8080 },
    "database": { "port": 9000 },
    "ui": { "enabled": true },
    "singleProjectMode": true
  }
}
'@

  Write-Host "Writing minimal firebase.json"
  $minimal | Out-File -FilePath $orig -Encoding UTF8 -Force

  # Ensure environment variables for seeder
  $env:USE_EMULATOR = 'true'
  $env:FIREBASE_PROJECT_ID = 'carelog-mv'
  $env:GCLOUD_PROJECT = $env:FIREBASE_PROJECT_ID
  $env:GOOGLE_CLOUD_PROJECT = $env:GCLOUD_PROJECT

  # Command to run inside emulator exec: on Windows use cmd /c to run a batch sequence
  # We created scripts\seed_and_echo.bat which runs the seeder and echoes when done.
  $inner = 'cmd /c scripts\\seed_and_echo.bat && flutter test integration_test\\emulator_integration_test.dart'

  Write-Host "Starting emulators via emulators:exec and running seeder + tests"
  # Use firebase.cmd explicitly on Windows to avoid shim execution issues
  $exitCode = & firebase.cmd emulators:exec $inner --only auth,firestore --project=carelog-mv

  Write-Host "emulators:exec finished with exit code $LASTEXITCODE"

  # Restore original firebase.json
  Write-Host "Restoring original firebase.json"
  Move-Item -Path $backup -Destination $orig -Force

  exit $LASTEXITCODE

} catch {
  Write-Host "Error during emulator swap/run: $_" -ForegroundColor Red
  if (Test-Path $backup) {
    Write-Host "Restoring backup firebase.json"
    Move-Item -Path $backup -Destination $orig -Force
  }
  exit 1
}
