# Helper script to start Firebase emulators and run integration tests locally (PowerShell)
# Usage: .\scripts\run_emulator_and_tests.ps1

param(
  [switch]$NoInstall
)

Write-Host "Starting Firebase Emulators (Auth, Firestore, Functions)..."
if (-not $NoInstall) {
  Write-Host "Ensure firebase-tools installed. If not, run: npm install -g firebase-tools"
}

Write-Host "Starting Firebase emulator (bound to 127.0.0.1)..."

# Launch emulator in a new window so logs are visible; use explicit host to prefer IPv4
# On Windows the npm global binary is a .cmd shim
Start-Process -FilePath "firebase.cmd" -ArgumentList "emulators:start --only auth,firestore,functions --host=127.0.0.1"

Write-Host "Waiting for emulators to be ready (probing ports 127.0.0.1:9099 and 127.0.0.1:8080)..."

function Test-PortOpen($hostname, $port) {
  try {
    $socket = New-Object System.Net.Sockets.TcpClient
    $iar = $socket.BeginConnect($hostname, $port, $null, $null)
    $success = $iar.AsyncWaitHandle.WaitOne(2000)
    if (-not $success) { return $false }
    $socket.EndConnect($iar)
    $socket.Close()
    return $true
  } catch {
    return $false
  }
}

$maxWait = 60  # seconds
$elapsed = 0
while ($elapsed -lt $maxWait) {
  $authOpen = Test-PortOpen -hostname '127.0.0.1' -port 9099
  $fsOpen = Test-PortOpen -hostname '127.0.0.1' -port 8080
  if ($authOpen -and $fsOpen) { break }
  Start-Sleep -Seconds 2
  $elapsed += 2
  Write-Host "Waiting... ($elapsed/$maxWait)"
}

if ($elapsed -ge $maxWait) {
  Write-Host "Emulators did not start within $maxWait seconds. Check emulator logs or run 'firebase emulators:start' interactively." -ForegroundColor Red
  exit 1
}

Write-Host "Emulators ready. Running seeder (node.exe)..."

if (Test-Path -Path "scripts\seed_firestore.js") {
  # Ensure seeder knows we're using emulators and which project id to use
  $env:USE_EMULATOR = 'true'
  $env:FIREBASE_PROJECT_ID = 'carelog-mv'
  $env:GCLOUD_PROJECT = $env:FIREBASE_PROJECT_ID
  $env:GOOGLE_CLOUD_PROJECT = $env:GCLOUD_PROJECT
  node.exe scripts\seed_firestore.js
} else {
  Write-Host "No seeder found: scripts/seed_firestore.js"
}

Write-Host "Running integration tests against emulators..."
flutter test integration_test/emulator_integration_test.dart

Write-Host "Done. If emulators were started in a separate window, stop them manually when finished." -ForegroundColor Green