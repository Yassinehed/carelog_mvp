Write-Host "🔁 Seeding Firebase Emulator (PowerShell)"

$env:USE_EMULATOR = 'true'
$env:FIREBASE_PROJECT_ID = 'carelog-mv'

if (Test-Path -Path "scripts\seed_firestore.js") {
    Write-Host "-> Running Node seeder (node.exe)"
    node.exe scripts\seed_firestore.js
} else {
    Write-Host "No seeder found: scripts/seed_firestore.js"
}

Write-Host "✅ Seeding complete"
