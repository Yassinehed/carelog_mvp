#!/usr/bin/env node

/**
 * Admin Claim Management Script
 *
 * This script provides secure management of admin custom claims for Firebase users.
 * It uses Firebase Admin SDK to set/revoke admin privileges.
 *
 * Usage:
 *   node admin-manager.js grant <uid>    - Grant admin privileges to user
 *   node admin-manager.js revoke <uid>   - Revoke admin privileges from user
 *   node admin-manager.js list            - List all users with admin claims
 *   node admin-manager.js check <uid>     - Check if user has admin privileges
 *
 * Environment Variables:
 *   FIREBASE_PROJECT_ID     - Firebase project ID
 *   FIREBASE_SERVICE_KEY    - Path to service account key file
 *   USE_EMULATOR           - Set to 'true' to use Firebase emulators
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Configuration
const config = {
  projectId: process.env.FIREBASE_PROJECT_ID || 'carelog-mv',
  serviceKeyPath: process.env.FIREBASE_SERVICE_KEY || path.join(__dirname, '..', 'keys', 'service-account-key.json'),
  useEmulator: process.env.USE_EMULATOR === 'true'
};

/**
 * Initialize Firebase Admin SDK
 */
function initializeFirebase() {
  try {
    // Check if service account key exists
    if (!fs.existsSync(config.serviceKeyPath)) {
      console.error(`❌ Service account key not found at: ${config.serviceKeyPath}`);
      console.error('Please set FIREBASE_SERVICE_KEY environment variable or place the key file in the correct location.');
      process.exit(1);
    }

    const serviceAccount = JSON.parse(fs.readFileSync(config.serviceKeyPath, 'utf8'));

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      projectId: config.projectId
    });

    // Use emulators if specified
    if (config.useEmulator) {
      process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
      process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';
      console.log('🔧 Using Firebase Emulators');
    }

    console.log(`✅ Firebase initialized for project: ${config.projectId}`);
  } catch (error) {
    console.error('❌ Failed to initialize Firebase:', error.message);
    process.exit(1);
  }
}

/**
 * Grant admin privileges to a user
 */
async function grantAdmin(uid) {
  try {
    console.log(`👑 Granting admin privileges to user: ${uid}`);

    await admin.auth().setCustomUserClaims(uid, { admin: true });

    console.log('✅ Admin privileges granted successfully');
    console.log(`🔍 You can verify this by running: node admin-manager.js check ${uid}`);
  } catch (error) {
    console.error('❌ Failed to grant admin privileges:', error.message);
    process.exit(1);
  }
}

/**
 * Revoke admin privileges from a user
 */
async function revokeAdmin(uid) {
  try {
    console.log(`🚫 Revoking admin privileges from user: ${uid}`);

    await admin.auth().setCustomUserClaims(uid, { admin: false });

    console.log('✅ Admin privileges revoked successfully');
    console.log(`🔍 You can verify this by running: node admin-manager.js check ${uid}`);
  } catch (error) {
    console.error('❌ Failed to revoke admin privileges:', error.message);
    process.exit(1);
  }
}

/**
 * Check if a user has admin privileges
 */
async function checkAdmin(uid) {
  try {
    console.log(`🔍 Checking admin status for user: ${uid}`);

    const userRecord = await admin.auth().getUser(uid);
    const customClaims = userRecord.customClaims || {};

    if (customClaims.admin === true) {
      console.log('✅ User has admin privileges');
      return true;
    } else {
      console.log('❌ User does not have admin privileges');
      return false;
    }
  } catch (error) {
    console.error('❌ Failed to check admin status:', error.message);
    process.exit(1);
  }
}

/**
 * List all users with admin claims
 */
async function listAdmins() {
  try {
    console.log('📋 Listing all users with admin privileges...');

    // Note: Firebase Admin SDK doesn't provide a direct way to list users by custom claims
    // This is a simplified implementation that would need to be enhanced for production
    console.log('⚠️  Note: This feature requires additional implementation for production use');
    console.log('💡 Consider implementing a users collection in Firestore to track admin users');

    // For now, we'll show a message about implementation
    console.log('📝 To implement this feature:');
    console.log('   1. Create a Firestore collection "admin_users"');
    console.log('   2. Add documents when granting admin privileges');
    console.log('   3. Remove documents when revoking privileges');
    console.log('   4. Query this collection to list admin users');

  } catch (error) {
    console.error('❌ Failed to list admin users:', error.message);
    process.exit(1);
  }
}

/**
 * Display usage information
 */
function showUsage() {
  console.log(`
👑 Firebase Admin Claim Management Script

USAGE:
  node admin-manager.js <command> [arguments]

COMMANDS:
  grant <uid>     Grant admin privileges to user with specified UID
  revoke <uid>    Revoke admin privileges from user with specified UID
  check <uid>     Check if user has admin privileges
  list            List all users with admin privileges (requires implementation)
  help            Show this help message

EXAMPLES:
  node admin-manager.js grant abc123def456
  node admin-manager.js revoke user789xyz
  node admin-manager.js check admin@example.com
  node admin-manager.js list

ENVIRONMENT VARIABLES:
  FIREBASE_PROJECT_ID     Firebase project ID (default: carelog-mv)
  FIREBASE_SERVICE_KEY    Path to service account key file
  USE_EMULATOR           Set to 'true' to use Firebase emulators

SECURITY NOTES:
  🔐 This script requires Firebase Admin SDK credentials
  🛡️  Store service account keys securely and never commit to version control
  📝 Use environment variables for configuration in production
  `);
}

/**
 * Main function
 */
async function main() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.error('❌ No command specified');
    showUsage();
    process.exit(1);
  }

  const command = args[0].toLowerCase();

  // Initialize Firebase for all commands except help
  if (command !== 'help') {
    initializeFirebase();
  }

  try {
    switch (command) {
      case 'grant':
        if (args.length < 2) {
          console.error('❌ User UID required for grant command');
          console.log('Example: node admin-manager.js grant abc123def456');
          process.exit(1);
        }
        await grantAdmin(args[1]);
        break;

      case 'revoke':
        if (args.length < 2) {
          console.error('❌ User UID required for revoke command');
          console.log('Example: node admin-manager.js revoke abc123def456');
          process.exit(1);
        }
        await revokeAdmin(args[1]);
        break;

      case 'check':
        if (args.length < 2) {
          console.error('❌ User UID required for check command');
          console.log('Example: node admin-manager.js check abc123def456');
          process.exit(1);
        }
        await checkAdmin(args[1]);
        break;

      case 'list':
        await listAdmins();
        break;

      case 'help':
      case '--help':
      case '-h':
        showUsage();
        break;

      default:
        console.error(`❌ Unknown command: ${command}`);
        showUsage();
        process.exit(1);
    }

    // Clean up Firebase app
    if (command !== 'help') {
      await admin.app().delete();
      console.log('🧹 Firebase connection cleaned up');
    }

  } catch (error) {
    console.error('💥 Unexpected error:', error.message);
    process.exit(1);
  }
}

// Handle process termination gracefully
process.on('SIGINT', async () => {
  console.log('\n⚠️  Received SIGINT, cleaning up...');
  try {
    await admin.app().delete();
  } catch (error) {
    // Ignore cleanup errors
  }
  process.exit(0);
});

process.on('SIGTERM', async () => {
  console.log('\n⚠️  Received SIGTERM, cleaning up...');
  try {
    await admin.app().delete();
  } catch (error) {
    // Ignore cleanup errors
  }
  process.exit(0);
});

// Run the script
if (require.main === module) {
  main().catch((error) => {
    console.error('💥 Fatal error:', error.message);
    process.exit(1);
  });
}

module.exports = {
  grantAdmin,
  revokeAdmin,
  checkAdmin,
  listAdmins
};