# Run seeder with emulator env vars and capture output
$env:USE_EMULATOR = 'true'
$env:GCLOUD_PROJECT = 'carelog-mv'
$env:GOOGLE_CLOUD_PROJECT = 'carelog-mv'
$env:FIRESTORE_EMULATOR_HOST = '127.0.0.1:8080'
$env:FIREBASE_AUTH_EMULATOR_HOST = '127.0.0.1:9099'

Write-Host "Running seeder (node.exe scripts\seed_firestore.js)"
node.exe .\scripts\seed_firestore.js *>&1 | Tee-Object -FilePath ..\seed-output.log
exit $LASTEXITCODE
