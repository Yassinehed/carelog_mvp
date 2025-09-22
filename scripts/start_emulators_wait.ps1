# Start Firebase emulators (auth + firestore) and wait until ports are listening
param(
  [int]$maxWaitSeconds = 60
)

Write-Host "Starting Firebase emulators (auth, firestore) and waiting up to $maxWaitSeconds seconds..."
$proc = Start-Process -FilePath "firebase.cmd" -ArgumentList "emulators:start --only auth,firestore --debug" -PassThru

$elapsed = 0
while ($elapsed -lt $maxWaitSeconds) {
  Start-Sleep -Seconds 1
  $elapsed += 1
  try {
    $auth = Test-NetConnection -ComputerName 127.0.0.1 -Port 9099 -WarningAction SilentlyContinue
    $fs = Test-NetConnection -ComputerName 127.0.0.1 -Port 8080 -WarningAction SilentlyContinue
    if ($auth.TcpTestSucceeded -and $fs.TcpTestSucceeded) {
      Write-Host "Emulators are listening (Auth:127.0.0.1:9099, Firestore:127.0.0.1:8080)"
      exit 0
    }
  } catch {
    # ignore transient errors
  }
}

Write-Host "Timed out waiting for emulators to be ready after $maxWaitSeconds seconds" -ForegroundColor Red
# leave process running for debugging
exit 1
