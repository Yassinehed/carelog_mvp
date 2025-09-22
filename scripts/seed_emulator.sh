#!/usr/bin/env bash
set -euo pipefail

echo "🔁 Seeding Firebase Emulator (bash)"

export USE_EMULATOR=true
export FIREBASE_PROJECT_ID=carelog-mv

# Create a test user via admin-manager.js (requires keys/service-account-key.json when not using emulator)
if [ -f "scripts/admin-manager.js" ]; then
  echo "-> Creating test user via admin-manager.js"
  # This script expects the first arg 'grant' or similar; we'll create a user via the seeder below instead
fi

node scripts/seed_firestore.js

echo "✅ Seeding complete"
