#!/usr/bin/env node
const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const useEmulator = process.env.USE_EMULATOR === 'true';

  if (useEmulator) {
  // Try IPv4 first, fallback to localhost (which might resolve to ::1 on some systems)
  process.env.FIRESTORE_EMULATOR_HOST = '127.0.0.1:8080';
  process.env.FIREBASE_AUTH_EMULATOR_HOST = '127.0.0.1:9099';
  console.log('🔧 Using Firebase Emulators for seeding (trying 127.0.0.1)');
    // Ensure admin SDK can resolve a project id without ADC when running against emulator
    process.env.GCLOUD_PROJECT = process.env.FIREBASE_PROJECT_ID || 'carelog-mv';
    process.env.GOOGLE_CLOUD_PROJECT = process.env.GCLOUD_PROJECT;
}

// Helper to try alternate host binding on failure
function setEmulatorHostFallback() {
  process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
  process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';
  console.log('🔧 Falling back to localhost for emulator hosts');
}

try {
  // If a service account exists, use it; otherwise when using emulator initialize with explicit projectId
  const serviceKeyPath = path.join(__dirname, '..', 'keys', 'service-account-key.json');
  if (fs.existsSync(serviceKeyPath)) {
    const serviceAccount = require(serviceKeyPath);
    admin.initializeApp({ credential: admin.credential.cert(serviceAccount), projectId: process.env.FIREBASE_PROJECT_ID || 'carelog-mv' });
  } else if (useEmulator) {
    // When running against the emulator, initialize with projectId only to avoid ADC lookup
    admin.initializeApp({ projectId: process.env.FIREBASE_PROJECT_ID || 'carelog-mv' });
  } else {
    // Fallback to default initialization which may rely on ADC in production
    admin.initializeApp();
  }

  const auth = admin.auth();
  const firestore = admin.firestore();

  async function seed() {
    console.log('-> Creating test user');
    // Create a user in the Auth emulator
    let userRecord;
    try {
      userRecord = await auth.getUserByEmail('test.user+emulator@example.com');
      console.log('-> Test user already exists:', userRecord.uid);
    } catch (e) {
      userRecord = await auth.createUser({
        email: 'test.user+emulator@example.com',
        emailVerified: true,
        password: 'password123',
        displayName: 'Test User'
      });
      console.log('-> Created test user:', userRecord.uid);
    }

    // Optionally set custom claims
    await auth.setCustomUserClaims(userRecord.uid, { admin: false });

    console.log('-> Seeding Firestore sample documents');
    const sampleDoc = firestore.collection('sample').doc('seed1');
    await sampleDoc.set({
      name: 'Seed Document',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      ownerUid: userRecord.uid
    });

    console.log('✅ Seeder finished');
    process.exit(0);
  }

  seed().catch((err) => {
    console.error('Seeder error:', err);
    process.exit(1);
  });
} catch (err) {
  console.error('Failed to initialize seeder:', err);
  process.exit(1);
}
