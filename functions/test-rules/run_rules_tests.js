const { initializeTestEnvironment, assertFails, assertSucceeds } = require('@firebase/rules-unit-testing');
const fs = require('fs');

(async () => {
  // Load rules
  const rules = fs.readFileSync('../firestore.rules', 'utf8');

  const testEnv = await initializeTestEnvironment({
    projectId: 'carelog-mv',
    firestore: {
      rules: rules,
    },
  });

  // Admin app with full privileges
  const adminContext = testEnv.authenticatedContext('adminUser', { admin: true });
  const userContext = testEnv.authenticatedContext('regularUser', { admin: false });

  // Create Firestore clients
  const adminDb = adminContext.firestore();
  const userDb = userContext.firestore();

  // Test: admin should be able to write to /config/system_status
  const adminWrite = adminDb.collection('config').doc('system_status').set({ isReadOnly: false });
  try {
    await assertSucceeds(adminWrite);
    console.log('Admin write to system_status succeeded (expected)');
  } catch (e) {
    console.error('Admin write failed (unexpected):', e);
    process.exit(1);
  }

  // Test: regular user should NOT be able to write to system_status
  const userWrite = userDb.collection('config').doc('system_status').set({ isReadOnly: false });
  try {
    await assertFails(userWrite);
    console.log('Regular user write to system_status failed (expected)');
  } catch (e) {
    console.error('Regular user write succeeded (unexpected):', e);
    process.exit(1);
  }

  await testEnv.cleanup();
  console.log('Rules tests completed successfully');
})();
